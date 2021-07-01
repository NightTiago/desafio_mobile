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

part 'signup_controller.g.dart';

class SignUpController = SignUpControllerBase with _$SignUpController;

abstract class SignUpControllerBase with Store {
  FirebaseCrashlytics _crashlyticsIns = FirebaseCrashlytics.instance;

  AnalyticsService _analyticsService = AnalyticsService();
  AuthenticationService _authService = AuthenticationService();

  @observable
  String _email = "";

  @observable
  String _password = "";

  @observable
  bool LOADING = false;

  late LatLng position;

  String get email => _email;

  String get password => _password;

  set setEmail(String value) {
    _email = value;
  }

  set setPassword(String value) {
    _password = value;
  }

  @action
  Future singUp() async {
    LOADING = true;
      try {
        await _authService.createUser(email: _email, password: _password);
        await _analyticsService.logSignUp();
        await getLocation();
        UserEntity user = UserEntity(
            // id: authUser.user.uid,
            email: _email,
            password: _password,
            latitude: position.latitude,
            longitude: position.longitude);
        await Modular.to.pushReplacementNamed('/', arguments: user);
        LOADING = false;
        return null;
      } catch (e) {
        FirebaseCrashlytics.instance.log(e.toString());
        LOADING = false;
        return e;
      }
  }

  Future getLocation() async {
    Position positionCurrent = await Geolocator.getCurrentPosition();
    position =
        LatLng(positionCurrent.latitude, positionCurrent.longitude);
  }
}
