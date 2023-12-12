import 'package:uuid/uuid.dart';

enum UserRole { user, admin }

class User {
  late String userId;
  late String username;
  late String email;
  late String password;
  UserRole role;

  User(this.userId, this.username, this.email, this.password, this.role);

  factory User.generateId(
      String username, String email, String password, UserRole role) {
    String uniqueId = Uuid().v4();

    // Combine the unique ID with user information to create a user ID
    String userId = '${role.toString()}_$uniqueId';

    return User(
      userId,
      username,
      email,
      password,
      role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'role': role.toString(),
    };
  }
}
