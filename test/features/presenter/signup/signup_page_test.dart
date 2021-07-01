import 'package:desafio_mobile/features/domain/entities/user_entity.dart';
import 'package:desafio_mobile/features/presenter/signup/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';

class MyNavigatorMock extends Mock implements IModularNavigator {
  @override
  Future<T?> pushNamed<T extends Object?>(String? routeName, {Object? arguments, bool? forRoot = false}) =>
      (super.noSuchMethod(Invocation.method(#pushNamed, [routeName], {#arguments: arguments, #forRoot: forRoot}), returnValue: Future.value(null)) as Future<T?>);
}

void main() async {
  setupFirebaseAuthMocks();
  await Firebase.initializeApp();
  var navigatorMock;
  setUpAll((){
    navigatorMock = MyNavigatorMock();
    // Modular.to and Modular.link will be called MyNavigatorMock implements!
    Modular.navigatorDelegate = navigatorMock;
  });


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
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.text("carregando..."), findsOneWidget);

    });

    // testWidgets('calls sing in method when email and password is entered by type CircularProgressIndicator',
    //         (WidgetTester tester) async {
    //       await tester.pumpWidget(testWidgetLoginPage);
    //       await tester.enterText(emailFormField, 'test2@test.com');
    //       await tester.enterText(passwordFormField, '123456');
    //       await tester.tap(signInButton);
    //       await tester.pump(Duration(seconds: 2));
    //
    //       expect(find.byType(CircularProgressIndicator), findsOneWidget);
    //     });
  });

  group('singup navigation test', () {
    test('test mock navigator to ROOT', () async {
      UserEntity user = UserEntity(
        // id: authUser.user.uid,
          email: 'test2@test.com',
          password: '123456',
          latitude: double.parse('2.7965843'),
          longitude: double.parse('-60.7117837'));
      when(navigatorMock.pushNamed('/', arguments: user)).thenAnswer((_) async => {});
      Modular.to.pushNamed('/', arguments: user);
      verify(navigatorMock.pushNamed('/', arguments: user)).called(1);
    });
  });


}
