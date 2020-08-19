

class UserExpense {

  final String issuerName;
  final String iconUrl;

  double amount;
  DateTime dueDate;

  UserExpense(this.issuerName, this.iconUrl, String amount, String dueDate) {

    this.amount = double.parse(amount);
    this.dueDate = DateTime.parse(dueDate);
  }

  //Returns a list of the class members for JSON serialization
  List toList() {
    return [issuerName, iconUrl, amount, dueDate.toIso8601String()];
  }

  //Converts a JSON serialized list into a class member
  static UserExpense fromList(List data) {


    UserExpense status = UserExpense(data[0], data[1], data[2], data[3]);

    return status;
  }
}