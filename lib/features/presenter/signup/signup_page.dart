import 'package:desafio_mobile/core/erros/errorHandler.dart';
import 'package:desafio_mobile/features/presenter/signup/controllers/signup_controller.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SignUpPage extends StatefulWidget {

  @override
  _SignUpPageState createState() =>
      _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  late ScrollController scrollController;
  late SignUpController signUpController;
  final GlobalKey<FormState> _formKeys = GlobalKey<FormState>();
  late bool actSignUp = false;

  @override
  void initState() {
    scrollController = ScrollController();
    signUpController = SignUpController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            controller: scrollController,
            child: SafeArea(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  height: MediaQuery.of(context).size.height,
                  child: Form(
                    key: _formKeys,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              key: Key('email-field'),
                              validator: (val) =>
                                  val!.isNotEmpty ? null : "Digite seu email",
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "E-mail:"),
                              keyboardType: TextInputType.visiblePassword,
                              onChanged: (val) {
                                signUpController.setEmail = val;
                              },
                            )),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
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
                                signUpController.setPassword = val;
                              },
                            )),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              key: Key('password2-field'),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Digite sua senha novamente por favor";
                                } else if (signUpController.password != val) {
                                  return "Senha não está igual";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Password:"),
                              obscureText: true,
                            )),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: ElevatedButton(
                                key: Key('signup-button'),
                                child: Observer(
                                    builder: (_) => signUpController.LOADING
                                        ? CircularProgressIndicator(
                                            backgroundColor: Colors.white,
                                          )
                                        : Text(actSignUp ? "carregando..." : "Cadastre-se",
                                            style: TextStyle(
                                                color: Colors.white))),
                                onPressed: () async {
                                  final formState = _formKeys.currentState;
                                  if (formState!.validate()) {
                                    actSignUp = true;
                                    dynamic ret = await signUpController.singUp();
                                    if(ret != null){
                                      ErrorHandler().errorDialog(context, ret);
                                    }
                                  }
                                }))
                      ],
                    ),
                  )),
            )));
  }
}
