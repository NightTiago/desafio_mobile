import 'package:desafio_mobile/features/data/datasources/data_base.dart';
import 'package:desafio_mobile/features/data/models/user_model.dart';
import 'package:desafio_mobile/features/domain/entities/user_entity.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  DataBase db = DataBase();

  @observable
  double lat = 0;

  @observable
  double long = 0;

  @observable
  bool LOADING = false;

  @action
  Future<Position?> moveCamera(GoogleMapController mapController) async {
    try {
      Position positionCurrent = await Geolocator.getCurrentPosition();
      LatLng position =
          LatLng(positionCurrent.latitude, positionCurrent.longitude);
      await mapController.moveCamera(CameraUpdate.newLatLng(position));
      LOADING = false;
      return positionCurrent;
    } on FlutterErrorDetails catch (e) {
      LOADING = false;
      FirebaseCrashlytics.instance.recordFlutterError(e);
    }
  }

  @action
  Future<void> adicionarUltimalocalizacao(UserEntity user) async {
    UserModel userModel = UserModel(
        email: user.email,
        latitude: user.latitude,
        longitude: user.longitude);
    DataBase.addItem(user: userModel);
  }

  @action
  void addMarker(double lat, double long, Set<Marker> markers) {
    LatLng position = LatLng(lat, long);
    final Marker marker = Marker(
        markerId: MarkerId("1"),
        position: position,
        infoWindow: InfoWindow(snippet: "Está sempre aqui", title: "hello !"));
    markers.add(marker);
  }
}
