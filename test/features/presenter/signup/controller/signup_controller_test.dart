import 'package:desafio_mobile/app_module.dart';
import 'package:desafio_mobile/features/domain/usecases/authentication_service.dart';
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


  // final BehaviorSubject<MockFirebaseUser> _user = BehaviorSubject<MockFirebaseUser>();
  // late MockAuthenticationService _repo;
  late AuthenticationService _repo;
  late SignUpController controller;
  final MockUser user = MockUser(
    isAnonymous: false,
    uid: 'someuid',
    email: 'bob@somedomain.com',
    displayName: 'Bob',
  );
  final _auth = MockFirebaseAuth(mockUser: user);

  setUpAll(() {
    controller = Modular.get();
     // _repo = MockAuthenticationService(auth: _auth);
    _repo = AuthenticationService.instance(auth: _auth);

  });

  group('Test de instancia de controller', () {
    //primeiro teste
    test('isInstanceOf test', () async {
      expect(controller, isInstanceOf<SignUpController>());
    });
  });

  group('AuthenticationService test', () {
    test("sign in with email and password by service", () async {
      dynamic signedIn = await _repo.loginUser(email: 'teste@teste.com', password: "123123a");
      expect(signedIn, isInstanceOf<MockUser>());
      expect(_repo.status, Status.Authenticated);
    });
  });

  group('SignUpController Test', () {
    // // singUp
    test('SignUpController click singUp', () async {
      controller.setEmail = 'teste@teste.com';
      controller.setPassword = '123456a';
      expect(await controller.singUp(), null);
    });
  });
}
