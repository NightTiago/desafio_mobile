import 'package:desafio_mobile/features/domain/entities/user_entity.dart';
import 'package:desafio_mobile/features/domain/usecases/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../presenter/mocks.dart';

void main() async {

  setupFirebaseAuthMocks();
  await Firebase.initializeApp();

  late AuthenticationService _repo;
  final MockUser user = MockUser(
    isAnonymous: false,
    uid: 'someuid',
    email: 'bob@somedomain.com',
    displayName: 'Bob',
  );
  final _auth = MockFirebaseAuth(mockUser: user);

  setUpAll(() {
    _repo = AuthenticationService.instance(auth: _auth);
  } );
  group('user repository test', () {



  });

}
