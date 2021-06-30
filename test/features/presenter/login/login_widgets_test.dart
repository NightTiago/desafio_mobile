import 'package:desafio_mobile/features/presenter/login/login_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks.dart';

void main() async {
  setupFirebaseAuthMocks();

  await Firebase.initializeApp();

  Widget testWidgetLoginPage =
      MediaQuery(data: MediaQueryData(), child: MaterialApp(home: LoginPage()));

  testWidgets('testing my widgets', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(testWidgetLoginPage);

    var emailFormField = find.byKey(Key('email-field'));
    var passwordFormField = find.byKey(Key('password-field'));
    var signUpButton = find.byKey(Key('singup-button'));
    var signInButton = find.byKey(Key('signin-button'));
    var titleText = find.text("BEM VINDO");

    expect(emailFormField, findsOneWidget);
    expect(passwordFormField, findsOneWidget);
    expect(signUpButton, findsOneWidget);
    expect(signInButton, findsOneWidget);
    expect(titleText, findsOneWidget);
  });
}
