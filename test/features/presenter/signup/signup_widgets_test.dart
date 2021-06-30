import 'package:desafio_mobile/features/presenter/login/login_page.dart';
import 'package:desafio_mobile/features/presenter/signup/signup_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks.dart';

void main() async {
  setupFirebaseAuthMocks();

  await Firebase.initializeApp();

  Widget testWidgetLoginPage = MediaQuery(
      data: MediaQueryData(), child: MaterialApp(home: SignUpPage()));

  testWidgets('testing my widgets', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(testWidgetLoginPage);

    var emailFormField = find.byKey(Key('email-field'));
    var passwordFormField = find.byKey(Key('password-field'));
    var password2FormField = find.byKey(Key('password2-field'));
    var signInButton = find.byKey(Key('signup-button'));

    expect(emailFormField, findsOneWidget);
    expect(passwordFormField, findsOneWidget);
    expect(password2FormField, findsOneWidget);
    expect(signInButton, findsOneWidget);
  });
}
