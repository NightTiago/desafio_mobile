import 'dart:js_util';

import 'package:desafio_mobile/app_module.dart';
import 'package:desafio_mobile/features/domain/entities/user_entity.dart';
import 'package:desafio_mobile/features/domain/usecases/authentication_service.dart';
import 'package:desafio_mobile/features/presenter/home/controllers/home_controller.dart';
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

  final MockUser user = MockUser(
    isAnonymous: false,
    uid: 'someuid',
    email: 'bob@somedomain.com',
    displayName: 'Bob',
  );
  final _auth = MockFirebaseAuth(mockUser: user);

  late HomeController homeController;

  setUpAll(() {
    homeController = Modular.get();
  });

  test('isInstanceOf of HomeController', () async {
    expect(homeController, isInstanceOf<HomeController>());
  });

  test('Put lat location for user', () async {
    var user = UserEntity(email: "test@test.com", password: "123456", latitude: 10000, longitude: 10000);
    var response = await homeController.adicionarUltimalocalizacao(user);
    expect(await response, isInstanceOf<dynamic>());
  });



}
