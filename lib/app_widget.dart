import 'package:desafio_mobile/features/domain/usecases/analytics_service.dart';
import 'package:desafio_mobile/features/presenter/login/login_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics analytics = FirebaseAnalytics();
    FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

    final _init = Firebase.initializeApp();
    return MaterialApp(
      initialRoute: '/login',
      navigatorObservers: <NavigatorObserver>[
        observer
      ],
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: _init,
          builder: (context, snapshot) {
            return LoginPage();
          }),
    ).modular();
  }
}

