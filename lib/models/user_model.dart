// Data class representing a user.
class UserModel {
  final String uid;
  final String name;
  final String email;
  final String role; // 'student' or 'startup'

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
  });

  // Converts Firestore data into a UserModel.
  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? 'student',
    );
  }

  // Converts a UserModel into data Firestore can store.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role,
    };
  }
}
