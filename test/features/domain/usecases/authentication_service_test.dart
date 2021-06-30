import 'package:desafio_mobile/features/domain/entities/user_entity.dart';
import 'package:desafio_mobile/features/domain/usecases/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../presenter/mocks.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  User _currentUser;

  MockFirebaseAuth(this._currentUser);

  Future<User> currentuser() async {
    return _currentUser;
  }
}

class MockUserEntity extends Mock implements UserEntity {
  final String email;
  final String password;
  final double latitude;
  final double longitude;

  MockUserEntity(
      {required this.email,
      required this.password,
      required this.latitude,
      required this.longitude});
}

class MockAuthResult extends Mock implements UserCredential {}

class MockFirebaseUser extends Mock implements User {}

void main() async {
  setupFirebaseAuthMocks();

  await Firebase.initializeApp();

  // final user = MockUser(
  //     displayName: 'Tiago',
  //     uid: 'someuid',
  //     email: 'tiago@burro.com',
  //     isAnonymous: false);

  final user = MockFirebaseUser();
  final auth = MockFirebaseAuth(user);
  BehaviorSubject<MockFirebaseUser> _user = BehaviorSubject<MockFirebaseUser>();
  AuthenticationService _repo = AuthenticationService.instance(auth: auth);

  // when(auth.authStateChanges().first).thenAnswer((_) { return _user });

  group('user repository test', () {
    when(auth.signInWithEmailAndPassword(
            email: "test2@test.com", password: "123456"))
        .thenAnswer((_) async {
      _user.add(MockFirebaseUser());
      return MockAuthResult();
    });

    when(auth.signInWithEmailAndPassword(email: "test", password: "123"))
        .thenThrow(() {
      return null;
    });

    test("sign in with email and password", () async {
      bool signedIn =
          await _repo.createUser(email: "test2@test.com", password: "123456");
      expect(signedIn, true);
    });

    test("sing in fails with incorrect email and password", () async {
      bool signedIn = await _repo.loginUser(email: "test", password: "123");
      expect(signedIn, false);
    });
  });

  group('user repository test', () {
    when(auth.createUserWithEmailAndPassword(
            email: "test3@test.com", password: "123456"))
        .thenAnswer((_) async {
      _user.add(MockFirebaseUser());
      return MockAuthResult();
    });

    when(auth.createUserWithEmailAndPassword(email: "", password: ""))
        .thenThrow(() {
      return null;
    });

    test("sign in with email and password", () async {
      bool signedIn =
          await _repo.createUser(email: "test4@test.com", password: "123456");
      expect(signedIn, true);
    });

    test("sing in fails with incorrect email and password", () async {
      bool signedIn = await _repo.createUser(email: "qwe", password: "123");
      expect(signedIn, false);
    });
  });
}
