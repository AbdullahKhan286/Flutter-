import 'package:e_notic_board/models/enums.dart';

class MUser{
  final String id;
  final String name;
  final String email;
  String? photoUrl;
  Role userRole;
  MUser({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
    this.userRole = Role.student
  });
  factory MUser.fromMap(data){
    return MUser(
      id: data["id"],
      email: data["email"],
      name: data["name"],
      photoUrl: data["url"],
      userRole: Role.values[data["role"]??0],
    );
  }
}