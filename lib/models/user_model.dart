class User{
  final String uid;
  User({this.uid});
}

class UserData{
  final String uid;
  final String name;
  final String email;
  final String username;
  final String phoneNumber;
  final String pin;
  final bool rememberMe;

  UserData({
    this.uid,
    this.name,
    this.email,
    this.username,
    this.phoneNumber,
    this.pin,
    this.rememberMe
});
}

