import 'package:desafio_mobile/features/domain/entities/user_entity.dart';
import 'package:desafio_mobile/features/presenter/home/controllers/home_controller.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  UserEntity user;

  HomePage({required this.user});

  @override
  _HomePageState createState() => _HomePageState(this.user);
}

class _HomePageState extends State<HomePage> {
  UserEntity user;

  _HomePageState(this.user);

  Set<Marker> markers = new Set<Marker>();

  late HomeController homeController;
  late GoogleMapController mapController;

  @override
  void initState() {
    homeController = HomeController();
    homeController.adicionarUltimalocalizacao(user);
    homeController.addMarker(user.latitude, user.longitude, markers);
    super.initState();
  }

  //Preciso do método aqui para que possa inicializar o meu controller
  //Comportamento padrão do plugin GoogleMap
  void isMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bem vindo, ${user.email}"),
      ),
      body: GoogleMap(
        onMapCreated: isMapCreated,
        markers: markers,
        initialCameraPosition: CameraPosition(
            zoom: 11, target: LatLng(user.latitude, user.longitude)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        child: Observer(
            builder: (_) => homeController.LOADING
                ? CircularProgressIndicator(backgroundColor: Colors.white)
                : Icon(Icons.refresh)),
        onPressed: () {
          homeController.LOADING = true;
          homeController.moveCamera(mapController).then((value) =>
              homeController.addMarker(
                  value!.latitude, value.longitude, markers));
              homeController.adicionarUltimalocalizacao(user);
        },
      ),
    );
  }
}
