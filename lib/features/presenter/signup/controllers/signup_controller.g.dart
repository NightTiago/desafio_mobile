// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignUpController on SignUpControllerBase, Store {
  final _$_emailAtom = Atom(name: 'SignUpControllerBase._email');

  @override
  String get _email {
    _$_emailAtom.reportRead();
    return super._email;
  }

  @override
  set _email(String value) {
    _$_emailAtom.reportWrite(value, super._email, () {
      super._email = value;
    });
  }

  final _$_passwordAtom = Atom(name: 'SignUpControllerBase._password');

  @override
  String get _password {
    _$_passwordAtom.reportRead();
    return super._password;
  }

  @override
  set _password(String value) {
    _$_passwordAtom.reportWrite(value, super._password, () {
      super._password = value;
    });
  }

  final _$LOADINGAtom = Atom(name: 'SignUpControllerBase.LOADING');

  @override
  bool get LOADING {
    _$LOADINGAtom.reportRead();
    return super.LOADING;
  }

  @override
  set LOADING(bool value) {
    _$LOADINGAtom.reportWrite(value, super.LOADING, () {
      super.LOADING = value;
    });
  }

  final _$singUpAsyncAction = AsyncAction('SignUpControllerBase.singUp');

  @override
  Future<dynamic> singUp() {
    return _$singUpAsyncAction.run(() => super.singUp());
  }

  @override
  String toString() {
    return '''
LOADING: ${LOADING}
    ''';
  }
}
