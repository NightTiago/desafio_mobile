// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on HomeControllerBase, Store {
  final _$latAtom = Atom(name: 'HomeControllerBase.lat');

  @override
  double get lat {
    _$latAtom.reportRead();
    return super.lat;
  }

  @override
  set lat(double value) {
    _$latAtom.reportWrite(value, super.lat, () {
      super.lat = value;
    });
  }

  final _$longAtom = Atom(name: 'HomeControllerBase.long');

  @override
  double get long {
    _$longAtom.reportRead();
    return super.long;
  }

  @override
  set long(double value) {
    _$longAtom.reportWrite(value, super.long, () {
      super.long = value;
    });
  }

  final _$LOADINGAtom = Atom(name: 'HomeControllerBase.LOADING');

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

  final _$moveCameraAsyncAction = AsyncAction('HomeControllerBase.moveCamera');

  @override
  Future<Position?> moveCamera(GoogleMapController mapController) {
    return _$moveCameraAsyncAction.run(() => super.moveCamera(mapController));
  }

  final _$adicionarUltimalocalizacaoAsyncAction =
      AsyncAction('HomeControllerBase.adicionarUltimalocalizacao');

  @override
  Future<void> adicionarUltimalocalizacao(UserEntity user) {
    return _$adicionarUltimalocalizacaoAsyncAction
        .run(() => super.adicionarUltimalocalizacao(user));
  }

  final _$HomeControllerBaseActionController =
      ActionController(name: 'HomeControllerBase');

  @override
  void addMarker(double lat, double long, Set<Marker> markers) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.addMarker');
    try {
      return super.addMarker(lat, long, markers);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
lat: ${lat},
long: ${long},
LOADING: ${LOADING}
    ''';
  }
}
