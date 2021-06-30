import 'package:desafio_mobile/features/domain/usecases/authentication_service.dart';
import 'package:desafio_mobile/features/presenter/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../domain/usecases/authentication_service_test.dart';
import '../home/home_page_test.dart';
import '../mocks.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  User _currentUser;

  MockFirebaseAuth(this._currentUser);

  Future<User> currentuser() async {
    return _currentUser;
  }
}

class MockAuthenticationService extends Mock implements AuthenticationService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // MockAuthenticationService.instance(this.auth);

  MockAuthenticationService();
}

void main() async {
  setupFirebaseAuthMocks();

  await Firebase.initializeApp();

  late AuthenticationService authService;

  setUp(() {
    authService = MockAuthenticationService();
    when(authService.loginUser(email: "test2@test.com", password: "123456"))
        .thenAnswer((_) => Future.value());
  });

  final user = MockFirebaseUser();
  final auth = MockFirebaseAuth(user);

  Widget testWidgetLoginPage =
      MediaQuery(data: MediaQueryData(), child: MaterialApp(home: LoginPage()));
  var emailFormField = find.byKey(Key('email-field'));
  var passwordFormField = find.byKey(Key('password-field'));
  var signUpButton = find.byKey(Key('singup-button'));
  var signInButton = find.byKey(Key('signin-button'));
  var testButton = find.byKey(Key('teste'));

  group('login page test', () {
    testWidgets('email, password and button were found',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidgetLoginPage);
      expect(emailFormField, findsOneWidget);
      expect(passwordFormField, findsOneWidget);
      expect(signUpButton, findsOneWidget);
      expect(signInButton, findsOneWidget);
    });

    testWidgets('validate empty email and password',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidgetLoginPage);
      await tester.tap(signInButton);
      await tester.pump();
      expect(find.text("Digite seu email por favor"), findsOneWidget);
      expect(find.text("Digite sua senha por favor"), findsOneWidget);
    });

    testWidgets('calls sing in method when email and password is entered',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidgetLoginPage);
      await tester.enterText(emailFormField, 'test2@test.com');
      await tester.enterText(passwordFormField, '123456');
      await tester.tap(signInButton);
      await tester.pump();
      verify(authService.loginUser(email: "test2@test.com", password: "123456"))
          .called(1);
    });

    testWidgets('calls text method when email is entered',
        (WidgetTester tester) async {
      var serviceTest = MockAuthenticationService();
      await tester.pumpWidget(testWidgetLoginPage);
      await tester.enterText(emailFormField, 'test2@test.com');
      await tester.tap(testButton);
      await tester.pump();
      verify(serviceTest.test(email: "test2@test.com")).called(1);
    });
  });
}
