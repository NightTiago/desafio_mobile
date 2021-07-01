import 'package:desafio_mobile/features/presenter/home/home_page.dart';
import 'package:desafio_mobile/features/presenter/login/login_page.dart';
import 'package:desafio_mobile/features/presenter/signup/controllers/signup_controller.dart';
import 'package:desafio_mobile/features/presenter/signup/signup_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {

  @override
  final List<Bind> binds = [
    Bind((i) {
      return SignUpController();
    }),
  ];

  @override
  final List<ModularRoute> routes = [
    // Simple route using the ChildRoute
    ChildRoute('/login', child: (_, __) => LoginPage()),
    ChildRoute('/', child: (_, args) => HomePage(user: args.data)),
    ChildRoute('/sign-up', child: (_, __) => SignUpPage()),
  ];
}
