import 'package:desafio_mobile/features/domain/entities/user_entity.dart';
import 'package:desafio_mobile/features/presenter/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';

class MockUserEntity extends Mock implements UserEntity {
  final String email;
  final String password;
  final double latitude;
  final double longitude;
  MockUserEntity(this.email, this.password, this.latitude, this.longitude);
}

void main() async {
  MockUserEntity user =
      MockUserEntity("test2@test.com", "123456", 10000, 10000);

  setupFirebaseAuthMocks();

  await Firebase.initializeApp();

  Widget testWidgetLoginPage = MediaQuery(
      data: MediaQueryData(), child: MaterialApp(home: HomePage(user: user)));

  testWidgets('testing my widgets', (WidgetTester tester) async {
    await tester.pumpWidget(testWidgetLoginPage);
    var reload = find.byType(FloatingActionButton);
    expect(reload, findsOneWidget);
  });
}
