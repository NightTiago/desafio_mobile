import 'package:desafio_mobile/features/presenter/home/controllers/home_controller.dart';
import 'package:desafio_mobile/features/presenter/home/home_page.dart';
import 'package:desafio_mobile/features/presenter/login/controllers/login_controller.dart';
import 'package:desafio_mobile/features/presenter/login/login_page.dart';
import 'package:desafio_mobile/features/presenter/signup/controllers/signup_controller.dart';
import 'package:desafio_mobile/features/presenter/signup/signup_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {

  @override
  final List<Bind> binds = [
    Bind((i) {
      return SignUpController();
    }),
    Bind((i) {
      return LoginController();
    }),
    Bind((i) {
      return HomeController();
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
