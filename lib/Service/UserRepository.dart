
class User {

  final String username;
  final String password;

  User({
    this.username = '',
    this.password = '',
  });

  User copyWith({
    String username,
    String password,
  }) {
    return User(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "User: $username";
  }
}

