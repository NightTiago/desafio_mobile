import 'package:desafio_mobile/core/erros/errorHandler.dart';
import 'package:desafio_mobile/features/domain/usecases/authentication_service.dart';
import 'package:desafio_mobile/features/presenter/login/controllers/login_controller.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late ScrollController scrollController;
  late LoginController loginController;
  final GlobalKey<FormState> _formKeys = GlobalKey<FormState>();
  late bool actSignIn = false;


  @override
  void initState() {
    loginController = LoginController();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          controller: scrollController,
          child: SafeArea(
            child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Form(
                  key: _formKeys,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(child: Text("BEM VINDO")),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: TextFormField(
                            key: Key('email-field'),
                            validator: (val) => val!.isNotEmpty
                                ? null
                                : "Digite seu email por favor",
                            decoration: InputDecoration(
                              hintText: "Email:",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (val) {
                              loginController.setEmail = val;
                            },
                          )),
                      Container(
                          child: TextFormField(
                        key: Key('password-field'),
                        validator: (val) => val!.isNotEmpty
                            ? null
                            : "Digite sua senha por favor",
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: "Password:"),
                        obscureText: true,
                        onChanged: (val) {
                          loginController.setPassword = val;
                        },
                      )),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          child: TextButton(
                            key: Key('singup-button'),
                            child: Text("Cadastre-se"),
                            onPressed: () {
                              Modular.to.pushNamed('/sign-up');
                            },
                          )),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.065,
                          width: MediaQuery.of(context).size.width * 0.6,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ElevatedButton(
                              key: Key('signin-button'),
                              child: Observer(
                                  builder: (_) => loginController.LOADING
                                      ? CircularProgressIndicator(
                                          backgroundColor: Colors.white,
                                        )
                                      : Text("Sign in",
                                      style: TextStyle(
                                          color: Colors.white))),
                              onPressed: () async {
                                final formState = _formKeys.currentState;
                                if (formState!.validate()) {
                                  actSignIn = true;
                                  dynamic ret = await loginController.singIn();
                                  if(ret != null){
                                    ErrorHandler().errorDialog(context, ret);
                                  }
                                }
                              }))
                    ],
                  ),
                )),
          )),
    );
  }
}
