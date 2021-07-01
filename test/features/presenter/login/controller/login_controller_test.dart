import 'package:desafio_mobile/app_module.dart';
import 'package:desafio_mobile/features/domain/usecases/authentication_service.dart';
import 'package:desafio_mobile/features/presenter/login/controllers/login_controller.dart';
import 'package:desafio_mobile/features/presenter/signup/controllers/signup_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.dart';

void main() async {

  setupFirebaseAuthMocks();
  await Firebase.initializeApp();

  initModule(AppModule());

  late LoginController controller;

  setUpAll(() {
    controller = Modular.get();
  });

    test('isInstanceOf of LoginController', () async {
      expect(controller, isInstanceOf<LoginController>());
    });

    test('LoginController click singIp', () async {
      controller.setEmail = 'teste@teste.com';
      controller.setPassword = '123456a';
      expect(await controller.singIn(), null);
    });
}
