import 'package:chat_app/core/services/typedefs.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  factory UserModel.fromMap(DataMap map) => UserModel(
        id: map['id'] as String,
        name: map['name'] as String,
        email: map['email'] as String,
        password: map['password'] as String,
      );

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String password;

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  DataMap toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
      };

  @override
  String toString() => 'UserModel(id: $id, email: $email, password: $password, '
      'name: $name';
}
