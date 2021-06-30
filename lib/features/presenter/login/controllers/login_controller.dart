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

  @action
  void setEmail(String valor) {
    _email = valor;
  }

  @action
  void setPassword(String valor) {
    _password = valor;
  }

  @action
  Future<void> singIn(
      GlobalKey<FormState> formKeys, BuildContext context) async {
    final formState = formKeys.currentState;
    if (formState!.validate()) {
      formState.save();
      try {
        await _authService.loginUser(email: _email, password: _password);
        await _analyticsService.logLogin();
        LatLng position = await getLocation();
        UserEntity user = UserEntity(
            // id: authUser!.uid,
            email: _email,
            password: _password,
            latitude: position.latitude,
            longitude: position.longitude);
        await Modular.to.pushReplacementNamed('/', arguments: user);
        LOADING = false;
      } catch (e) {
        LOADING = false;
        ErrorHandler().errorDialog(context, e);
        FirebaseCrashlytics.instance.log(e.toString());
      }
    }
    LOADING = false;
  }

  Future<LatLng> getLocation() async {
    Position positionCurrent = await Geolocator.getCurrentPosition();
    LatLng position =
        LatLng(positionCurrent.latitude, positionCurrent.longitude);
    return position;
  }
}
