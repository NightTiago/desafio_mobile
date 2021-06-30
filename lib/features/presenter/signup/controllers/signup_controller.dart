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

  String get email => _email;

  String get password => _password;

  set email(String value) {
    _email = value;
  }

  set password(String value) {
    _password = value;
  }

  @action
  Future singUp(GlobalKey<FormState> formKeys, BuildContext context) async {
    final formState = formKeys.currentState;
    if (formState!.validate()) {
      try {
        var authUser =
            await _authService.createUser(email: _email, password: _password);
        await _analyticsService.logSignUp();
        LatLng position = (await getLocation());
        UserEntity user = UserEntity(
            id: authUser.user.uid,
            email: _email,
            password: _password,
            latitude: position.latitude,
            longitude: position.longitude);
        await Modular.to.pushReplacementNamed('/', arguments: user);
        LOADING = false;
      } on FlutterErrorDetails catch (e) {
        ErrorHandler().errorDialog(context, e);
        FirebaseCrashlytics.instance.recordFlutterError(e);
        LOADING = false;
      }
    }
  }

  Future<LatLng> getLocation() async {
    Position positionCurrent = await Geolocator.getCurrentPosition();
    LatLng position =
        LatLng(positionCurrent.latitude, positionCurrent.longitude);
    return position;
  }
}
