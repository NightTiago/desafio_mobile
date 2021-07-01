import 'package:desafio_mobile/features/domain/entities/user_entity.dart';
import 'package:desafio_mobile/features/domain/usecases/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../presenter/mocks.dart';


class MockFirebaseUser extends Mock implements User {}
class MockAuthResult extends Mock implements UserCredential {}

void main() async {
  setupFirebaseAuthMocks();
  await Firebase.initializeApp();


  final BehaviorSubject<MockFirebaseUser> _user = BehaviorSubject<MockFirebaseUser>();
  // late MockAuthenticationService _repo;
  late AuthenticationService _repo;
  final MockUser user = MockUser(
    isAnonymous: false,
    uid: 'someuid',
    email: 'bob@somedomain.com',
    displayName: 'Bob',
  );
  final _auth = MockFirebaseAuth(mockUser: user);

  setUpAll(() {
    // _repo = MockAuthenticationService(auth: _auth);
    _repo = AuthenticationService.instance(auth: _auth);

  });

  group('user repository test', () {
    when(_auth.signInWithEmailAndPassword(
            email: "5@test.com", password: "123456"))
        .thenAnswer((_) async {
      _user.add(MockFirebaseUser());
      return MockAuthResult();
    });

    // when(auth.signInWithEmailAndPassword(email: "test", password: "123"))
    //     .thenThrow(() {
    //   return null;
    // });

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
    // when(auth.createUserWithEmailAndPassword(
    //         email: "test3@test.com", password: "123456"))
    //     .thenAnswer((_) async {
    //   _user.add(MockFirebaseUser());
    //   return MockAuthResult();
    // });

    // when(auth.createUserWithEmailAndPassword(email: "", password: ""))
    //     .thenThrow(() {
    //   return null;
    // });

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
