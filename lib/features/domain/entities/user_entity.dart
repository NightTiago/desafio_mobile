import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  // final String id;
  final String email;
  final String password;
  final double latitude;
  final double longitude;

  UserEntity(
      {
      // required this.id,
      required this.email,
      required this.password,
      required this.latitude,
      required this.longitude});

  @override
  List<Object?> get props => throw [email, password, latitude, longitude];
}
