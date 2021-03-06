import 'package:flutter/material.dart';
import 'package:Pesquisei/controllers/auth.controller.dart';
import 'package:Pesquisei/controllers/signup.controller.dart';
import 'package:Pesquisei/stores/app.store.dart';
import 'package:Pesquisei/view-models/signup.viewmodel.dart';
import 'package:provider/provider.dart';

import 'home/home.view.dart';

class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = new SignupController();

  var model = new SignupViewModel();

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<AppStore>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text("Login"),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Usuário",
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe seu usuário.';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    model.name = val;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Senha Inválida!';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    model.password = val;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                model.busy
                    ? Center(
                        child: Container(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.black,
                          ),
                        ),
                      )
                    : FlatButton(
                        color: Theme.of(context).primaryColor,
                        child: Text("Entrar"),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();

                            // TODO: Validação de login

                            Future<void> _showMyDialog() async {
                              return showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Falha no login'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text('Usuário e/ou senha inválidos.'),
                                          Text('Tente fazer login novamente.'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }

                            // TODO: Alterar validação de credenciais pelo retorno da busca  usuário na controller.

                            if (model.name.trim() != 'admin' ||
                                model.password.trim() != 'admin123') {
                              _showMyDialog();
                            } else {
                              setState(() {});
                              _controller.create(model).then((data) {
                                setState(() {});

                                store.setUser(
                                  data.name,
                                  data.pass,
                                  data.email,
                                  data.picture,
                                  data.token,
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(),
                                  ),
                                );
                              });
                            }
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
