import 'package:desafio_mobile/features/domain/usecases/authentication_service.dart';
import 'package:desafio_mobile/features/presenter/login/login_page.dart';
import 'package:desafio_mobile/features/presenter/signup/signup_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../mocks.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseUser extends Mock implements User {}

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}

class MockFirebaseAnalyticsObserver extends Mock
    implements FirebaseAnalyticsObserver {
  final MockFirebaseAnalytics analytics;
  MockFirebaseAnalyticsObserver({required this.analytics});
}

void main() async {
  setupFirebaseAuthMocks();

  await Firebase.initializeApp();

  var emailFormField = find.byKey(Key('email-field'));
  var passwordFormField = find.byKey(Key('password-field'));
  var password2FormField = find.byKey(Key('password2-field'));
  var signInButton = find.byKey(Key('signup-button'));

  Widget testWidgetLoginPage = MediaQuery(
      data: MediaQueryData(), child: MaterialApp(home: SignUpPage()));

  group('singup page test', () {
    testWidgets('email, password and button were found',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidgetLoginPage);
      expect(emailFormField, findsOneWidget);
      expect(passwordFormField, findsOneWidget);
      expect(signInButton, findsOneWidget);
    });

    testWidgets('validate empty email and password',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidgetLoginPage);
      await tester.tap(signInButton);
      await tester.pump();
      expect(find.text("Digite seu email"), findsOneWidget);
      expect(find.text("Digite sua senha por favor"), findsOneWidget);
      expect(find.text("Digite sua senha novamente por favor"), findsOneWidget);
    });

    testWidgets('validate password confirmation different',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidgetLoginPage);
      await tester.enterText(emailFormField, 'test2@test.com');
      await tester.enterText(passwordFormField, '123456');
      await tester.enterText(password2FormField, '1234567');
      await tester.tap(signInButton);
      await tester.pump();
      expect(find.text("Senha não está igual"), findsOneWidget);
    });

    testWidgets('calls sing in method when email and password is entered',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidgetLoginPage);
      await tester.enterText(emailFormField, 'test2@test.com');
      await tester.enterText(passwordFormField, '123456');
      await tester.tap(signInButton);
      await tester.pump();
      verify(() => _authService.loginUser(
          email: "test2@test.com", password: "123456")).called(1);
    });
  });
}
