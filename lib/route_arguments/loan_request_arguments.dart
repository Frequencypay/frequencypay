import 'package:frequencypay/models/user_expense_model.dart';

//This class represents the arguments required to transition to the loan request screen using Flutter routes
class LoanRequestArguments {

  //The expense to be displayed
  UserExpense expense;

  LoanRequestArguments(this.expense);
}