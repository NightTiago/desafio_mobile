import 'package:desafio_mobile/features/domain/entities/user_entity.dart';

class UserModel {

  String? id;
  String? email;
  double? latitude;
  double? longitude;

  UserModel({this.id, this.email, this.latitude, this.longitude});

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json['id'],
      email: json['email'],
      latitude: json['latitude'],
      longitude: json['longitude']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "latitude": latitude,
      "longitude": longitude
    };
  }

}
