class User {
  late String username;
  late String email;
  late String password;
  String role;

  User(this.username, this.email, this.password, this.role);

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'role': role,
    };
  }
}
