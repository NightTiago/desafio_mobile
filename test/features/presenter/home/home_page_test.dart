import 'package:desafio_mobile/features/domain/entities/user_entity.dart';
import 'package:desafio_mobile/features/domain/usecases/authentication_service.dart';
import 'package:desafio_mobile/features/presenter/home/home_page.dart';
import 'package:desafio_mobile/features/presenter/login/login_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}

class MockFirebaseAnalyticsObserver extends Mock
    implements FirebaseAnalyticsObserver {
  final MockFirebaseAnalytics analytics;

  MockFirebaseAnalyticsObserver({required this.analytics});
}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockAuthenticationService extends Mock implements AuthenticationService {}

class MockUserEntity extends Mock implements UserEntity {
  final String email;
  final String password;
  final double latitude;
  final double longitude;
  MockUserEntity(this.email, this.password, this.latitude, this.longitude);
}

void main() async {
  setupFirebaseAuthMocks();

  MockUserEntity user =
      MockUserEntity("test2@test.com", "123456", 10000, 10000);

  late MockFirebaseAuth _auth;

  late MockAuthenticationService _authService;

  setUpAll(() async {
    await Firebase.initializeApp();
    _auth = new MockFirebaseAuth();
    _authService = new MockAuthenticationService();
  });

  Widget testWidgetLoginPage = MediaQuery(
      data: MediaQueryData(), child: MaterialApp(home: HomePage(user: user)));

  var signInButton = find.byType(FloatingActionButton);

  group('home page test', () {
    testWidgets('email, password and button were found',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidgetLoginPage);
      expect(signInButton, findsOneWidget);
    });
  });
}
