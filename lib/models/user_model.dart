class User{
  final String uid;
  User({this.uid});
}

class UserData{
  final String uid;
  final String fname;
  final String lname;
  final String email;
  final String username;
  final String phoneNumber;
  final String address;
  final String pin;
  final String avatarUrl;
  final String notificationToken;

  UserData({
    this.uid,
    this.fname,
    this.lname,
    this.email,
    this.username,
    this.phoneNumber,
    this.address,
    this.pin,
    this.avatarUrl,
    this.notificationToken,
});
}

