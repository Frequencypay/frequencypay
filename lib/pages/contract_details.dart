import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frequencypay/blocs/contract_details_bloc.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/route_arguments/contract_details_arguments.dart';
import 'package:frequencypay/services/contract_service.dart';
import 'package:frequencypay/services/firestore_db_service.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class ContractDetails extends StatefulWidget {
  ContractDetails();

  @override
  _ContractDetailsState createState() => _ContractDetailsState();
}

class _ContractDetailsState extends State<ContractDetails> {
  static const Color blueHighlight = const Color(0xFF3665FF);

  ContractDetailsBloc bloc;

  //The contract being described
  Contract contract;

  _ContractDetailsState();

  ContractDetailsBloc createBloc(var context, Contract contract) {
    final user = Provider.of<User>(context, listen: false);

    FirestoreService firestoreService = FirestoreService(uid: user.uid);
    ContractService contractService = ContractService(firestoreService);

    bloc = ContractDetailsBloc(firestoreService, contractService);

    bloc.add(LoadContractDetailsEvent(contract));

    print("Selected contract transactions: " +
        contract.scheduledTransactions.toString());

    return bloc;
  }

  @override
  Widget build(BuildContext context) {
    //Extracting the contract assigned to load this page
    final ContractDetailsArguments arguments =
        ModalRoute.of(context).settings.arguments;

    //Retrieve the contract from the route arguments
    contract = arguments.contract;

    return BlocProvider(
      create: (context) => createBloc(context, contract),
      child: Scaffold(
//      appBar: AppBar(title: Text('Your' + contract()),),
        body: SingleChildScrollView(
          child: SafeArea(
            child: BlocBuilder<ContractDetailsBloc, ContractDetailsState>(
              builder: (context, state) {
                return Column(
                  children: <Widget>[
                    greetingMessage(),
                    SizedBox(height: 25),
                    getBillIssuer(),
                    Visibility(
                        visible:
                            contract.state == CONTRACT_STATE.ACTIVE_CONTRACT,
                        child: SizedBox(height: 15)),
                    Visibility(
                        visible:
                            contract.state == CONTRACT_STATE.ACTIVE_CONTRACT,
                        child: getProgress()),
                    Visibility(
                        visible:
                            contract.state == CONTRACT_STATE.ACTIVE_CONTRACT,
                        child: SizedBox(height: 35)),
                    summaryBanner(),
                    Visibility(
                        visible:
                            contract.state == CONTRACT_STATE.ACTIVE_CONTRACT,
                        child: SizedBox(height: 25)),
                    Visibility(
                        visible:
                            contract.state == CONTRACT_STATE.ACTIVE_CONTRACT,
                        child: makePaymentButton()),
                    Visibility(visible: true, child: SizedBox(height: 30)),
                    RepaymentInfo(state),
                    Visibility(visible: true, child: SizedBox(height: 15)),
                    ContractDetailsInfo(state),
                    Visibility(
                        visible:
                            contract.state == CONTRACT_STATE.ACTIVE_CONTRACT,
                        child: SizedBox(height: 30)),
                    Visibility(
                        visible:
                            contract.state == CONTRACT_STATE.ACTIVE_CONTRACT,
                        child: getHistory()),
                    Visibility(visible: true, child: SizedBox(height: 30)),
                    Visibility(
                        visible: _displayResponseButtons(state),
                        child: responseButtons()),
                    Visibility(visible: true, child: SizedBox(height: 15)),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget greetingMessage() {
    return Row(
      children: <Widget>[
        BackButton(color: blueHighlight),
        Text("  Your ",
            style: TextStyle(color: Color(0xFF8C8C8C), fontSize: 18)),
        Text("Contract ",
            style: TextStyle(
                color: blueHighlight,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget getBillIssuer() {
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.blue[900],
          child: Text("ISSUER"),
          radius: 35,
        ),
        SizedBox(height: 10),
        Text("<<Bill Issuer>>",
            style: TextStyle(fontSize: 18, color: Color(0xFF575757))),
      ],
    );
  }

  Widget getProgress() {
    return BlocBuilder<ContractDetailsBloc, ContractDetailsState>(
        builder: (context, state) {
      if (state is ContractDetailsIsLoadedState) {
        return _progressBar(contract.repaymentProgress);
      } else if (state is ContractDetailsIsLoadingState) {
        return _progressBar(0.0);
      } else {
        return _progressBar(0.0);
      }
    });
  }

  Widget _progressBar(double amount) {
    return LinearPercentIndicator(
      width: 235,
      lineHeight: 8.0,
      percent: amount,
      progressColor: Color(0xFFB64FFA),
      alignment: MainAxisAlignment.center,
    );
  }

  Widget summaryBanner() {
    return Row(
      children: <Widget>[
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 5,
          child: Column(
            children: <Widget>[
              CircleAvatar(
                child: Text("User"),
                radius: 25,
              ),
              SizedBox(
                height: 5,
              ),
              Builder(builder: (BuildContext context) {
                String avatarMessage = "";

                if (contract.state == CONTRACT_STATE.ACTIVE_CONTRACT ||
                    contract.state == CONTRACT_STATE.COMPLETED_CONTRACT) {
                  avatarMessage = contract.loanerName +
                      " paid on\n" +
                      DateFormat.MMMMd()
                          .format(DateTime.parse(contract.dateAccepted));
                } else {
                  avatarMessage = contract.loanerName;
                }

                return Text(avatarMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700], fontSize: 14));
              }),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: BlocBuilder<ContractDetailsBloc, ContractDetailsState>(
              builder: (context, state) {

            if (state is ContractDetailsIsLoadedState) {
              if (contract.state == CONTRACT_STATE.ACTIVE_CONTRACT) {
                return Text(
                    "Repay in full\non " +
                        DateFormat.yMd().format(state.getFinalPaymentDate),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700], fontSize: 14));
              } else if (contract.state == CONTRACT_STATE.COMPLETED_CONTRACT) {
                return Text("Repaid in full\non " + "<<date>>",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700], fontSize: 14));
              } else {
                return Text(
                    "Repaid in full\non " +
                        DateFormat.yMd()
                            .format(state.getRepaymentProjection.repaymentDate),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700], fontSize: 14));
              }
            } else if (state is ContractDetailsIsLoadingState) {
              return Text("Repay in full\non ...",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700], fontSize: 14));
            } else {
              return Text("Error obtaining\nrepayment date",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700], fontSize: 14));
            }
          }),
        ),
        Expanded(
          flex: 5,
          child: BlocBuilder<ContractDetailsBloc, ContractDetailsState>(
              builder: (context, state) {
            if (state is ContractDetailsIsLoadedState) {
              return _amountMessage(false);
            } else if (state is ContractDetailsIsLoadingState) {
              return _amountMessage(true);
            } else {
              return Container();
            }
          }),
        ),
        Expanded(flex: 1, child: Container()),
      ],
    );
  }

  Widget _amountMessage(bool stillLoading) {
    String amountMessage;
    String subtitle;

    if (contract.state == CONTRACT_STATE.OPEN_REQUEST) {
      amountMessage = "\$" + contract.terms.amount.toString();
      subtitle = "to be repaid";
    } else if (contract.state == CONTRACT_STATE.ACTIVE_CONTRACT) {
      if (stillLoading) {
        amountMessage = "...";
      } else {
        amountMessage =
            "\$" + contract.repaymentStatus.remainingAmount.toString();
      }
      subtitle = "remaining for repayment";
    } else {
      amountMessage = "\$" + contract.terms.amount.toString();
      subtitle = "repaid";
    }

    return Column(children: <Widget>[
      Text(amountMessage,
          style: TextStyle(
              color: blueHighlight, fontSize: 20, fontWeight: FontWeight.bold)),
      Text(subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[700], fontSize: 14))
    ]);
  }

  Widget makePaymentButton() {
    return RaisedButton(
      child: Text("Make Payment",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      onPressed: () {},
      color: Color(0xFFB64FFA),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
      elevation: 10,
    );
  }

  Widget RepaymentInfo(ContractDetailsState state) {
    String repaymentMessage;
    String amountMessage;
    String occurrenceMessage;

    amountMessage = "\$" + contract.terms.repaymentAmount.toString();

    if (state is ContractDetailsIsLoadedState) {
      occurrenceMessage = _convertOccurrence(contract.terms.frequencyWeeks);
    } else {
      occurrenceMessage = "...";
    }

    if (contract.state == CONTRACT_STATE.ACTIVE_CONTRACT) {
      repaymentMessage = contract.scheduledTransactions.length.toString() +
          " payments\nremaining";
    } else if (contract.state == CONTRACT_STATE.OPEN_REQUEST) {
      if (state is ContractDetailsIsLoadedState) {
        repaymentMessage = state.getRepaymentProjection.numPayments.toString() +
            " payments\nof";
      } else {
        repaymentMessage = "To be repaid over ...";
      }
    } else {
      repaymentMessage = "repaid over " + "X" + "\npayments";
    }

    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: blueHighlight,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Repayment",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
            SizedBox(height: 25),
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Text(repaymentMessage,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white, fontSize: 14))),
                Expanded(
                    flex: 1,
                    child: RichText(
                        textAlign: TextAlign.right,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: amountMessage + "\n",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: occurrenceMessage,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14))
                        ]))),
              ],
            ),
          ],
        ));
  }

  Widget ContractDetailsInfo(ContractDetailsState state) {
    String paymentMessage;
    String dueDateMessage;

    dueDateMessage =
        "Bill due date\n" + DateFormat.MMMd().format(contract.dueDate);

    if (contract.state == CONTRACT_STATE.OPEN_REQUEST) {
      paymentMessage = contract.loanerName +
          " will pay \$" +
          contract.terms.amount.toString() +
          "\nto " +
          "<<Bill Issuer>>";
    } else {
      paymentMessage = contract.loanerName +
          " paid \$" +
          contract.terms.amount.toString() +
          "\nto " +
          "<<Bill Issuer>>";
    }

    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: blueHighlight,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Contract Details",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
            SizedBox(height: 25),
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Text(paymentMessage,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white, fontSize: 14))),
                Expanded(
                    flex: 1,
                    child: Text(dueDateMessage,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.white, fontSize: 14))),
              ],
            ),
          ],
        ));
  }

  Widget getHistory() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [BoxShadow(blurRadius: 5.0)],
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("History",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Color(0xFF8C8C8C), fontSize: 11)),
              ],
            ),
            SizedBox(height: 15),
            historyEvent(),
            SizedBox(height: 10),
            historyEvent(),
            SizedBox(height: 10),
            historyEvent(),
          ],
        ));
  }

  Widget historyEvent() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: CircleAvatar(
            radius: 20,
            child: Text("user"),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: <Widget>[
              Text("You paid <<User>>",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Color(0xFF595959), fontSize: 10)),
              Text("<<Month>> <<Day>>",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Color(0xFF8C8C8C), fontSize: 10)),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Text("<<Amount>>",
              textAlign: TextAlign.right,
              style: TextStyle(color: Color(0xFF68BA76), fontSize: 11)),
          //color for positive value (0xFF68BA76)
          //color for negative value (0xFFEE5353)
        )
      ],
    );
  }

  bool _displayResponseButtons(ContractDetailsState state) {

    return contract.state == CONTRACT_STATE.OPEN_REQUEST && state is ContractDetailsIsLoadedState && state.isWaitedOnUse;
  }

  Widget responseButtons() {
    return Row(children: <Widget>[
      Expanded(flex: 1, child: Container()),
      Expanded(
          flex: 2, child: _responseButton("Accept", attemptAcceptContract)),
      Expanded(flex: 1, child: Container()),
      Expanded(
          flex: 2, child: _responseButton("Reject", attemptRejectContract)),
      Expanded(flex: 1, child: Container()),
    ]);
  }

  //Builds a response button
  Widget _responseButton(String text, var pressEvent) {
    return BlocBuilder<ContractDetailsBloc, ContractDetailsState>(
      builder: (context, state) {
        if (state is ContractDetailsIsLoadedState) {
          return _responseButtonWidget(text, pressEvent);
        } else if (state is ContractDetailsIsNotLoadedState) {
          return _responseButtonWidget(text, null);
        } else {
          return _responseButtonWidget(text, null);
        }
      },
    );
  }

  Widget _responseButtonWidget(String text, var pressEvent) {
    return /*FlatButton(
        child: Text(text, style: TextStyle(color: Colors.grey)),
        color: Colors.white24,
        onPressed: pressEvent);*/

        RaisedButton(
      child: Text(text,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
      onPressed: pressEvent,
      color: Color(0xFFB64FFA),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
      elevation: 5,
    );
  }

  //Attempts to accept the contract
  void attemptAcceptContract() {
    //Attempt to establish the contract
    bloc.add(EstablishContractContractDetailsEvent());
  }

  //Attempts to reject the contract
  void attemptRejectContract() {
    //Attempt to reject the contract
    bloc.add(RejectContractContractDetailsEvent());
  }

  //Converts a frequency of payment into a string message
  String _convertOccurrence(int weeks) {
    String message;

    switch (weeks) {
      case 0:
        message = "invalid duration";
        break;
      case 1:
        message = "Each week";
        break;
      case 2:
        message = "Every other week";
        break;
      default:
        if (weeks < 0) {
          message = "invalid duration";
        } else {
          message = "Every " + weeks.toString() + " weeks";
        }
        break;
    }

    return message;
  }
}
