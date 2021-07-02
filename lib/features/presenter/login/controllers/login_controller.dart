import 'package:desafio_mobile/core/erros/errorHandler.dart';
import 'package:desafio_mobile/features/domain/entities/user_entity.dart';
import 'package:desafio_mobile/features/domain/usecases/analytics_service.dart';
import 'package:desafio_mobile/features/domain/usecases/authentication_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  AnalyticsService _analyticsService = AnalyticsService();
  AuthenticationService _authService = AuthenticationService();

  @observable
  String _email = "";

  @observable
  String _password = "";

  @observable
  bool LOADING = false;

  String get email => _email;

  String get password => _password;

  set setEmail(String valor) {
    _email = valor;
  }

  set setPassword(String valor) {
    _password = valor;
  }

  @action
  Future singIn() async {
    LOADING = true;
    try {
        await _authService.loginUser(email: _email, password: _password);
        await _analyticsService.logLogin();
        LatLng position = await getLocation();
        UserEntity user = UserEntity(
            email: _email,
            password: _password,
            latitude: position.latitude,
            longitude: position.longitude);
        await Modular.to.pushReplacementNamed('/', arguments: user);
        LOADING = false;
        return null;
      } catch (e) {
        LOADING = false;
        FirebaseCrashlytics.instance.log(e.toString());
        return e;
      }
    }


  Future<LatLng> getLocation() async {
    Position positionCurrent = await Geolocator.getCurrentPosition();
    LatLng position =
        LatLng(positionCurrent.latitude, positionCurrent.longitude);
    return position;
  }
}
