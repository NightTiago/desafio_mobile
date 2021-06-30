// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on LoginControllerBase, Store {
  final _$_emailAtom = Atom(name: 'LoginControllerBase._email');

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

  final _$_passwordAtom = Atom(name: 'LoginControllerBase._password');

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

  final _$LOADINGAtom = Atom(name: 'LoginControllerBase.LOADING');

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

  final _$singInAsyncAction = AsyncAction('LoginControllerBase.singIn');

  @override
  Future<void> singIn(GlobalKey<FormState> formKeys, BuildContext context) {
    return _$singInAsyncAction.run(() => super.singIn(formKeys, context));
  }

  final _$LoginControllerBaseActionController =
      ActionController(name: 'LoginControllerBase');

  @override
  void setEmail(String valor) {
    final _$actionInfo = _$LoginControllerBaseActionController.startAction(
        name: 'LoginControllerBase.setEmail');
    try {
      return super.setEmail(valor);
    } finally {
      _$LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String valor) {
    final _$actionInfo = _$LoginControllerBaseActionController.startAction(
        name: 'LoginControllerBase.setPassword');
    try {
      return super.setPassword(valor);
    } finally {
      _$LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
LOADING: ${LOADING}
    ''';
  }
}
