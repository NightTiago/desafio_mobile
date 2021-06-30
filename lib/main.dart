import 'dart:async';

import 'package:desafio_mobile/app_module.dart';
import 'package:desafio_mobile/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runZonedGuarded(() {
      runApp(ModularApp(module: AppModule(), child: AppWidget()));
      }, FirebaseCrashlytics.instance.recordError);
}
