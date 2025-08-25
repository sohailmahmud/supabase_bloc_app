import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({required super.id, required super.email});

  factory UserModel.fromSupabase(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
    );
  }
}
