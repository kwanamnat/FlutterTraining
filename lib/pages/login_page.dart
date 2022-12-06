import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_mobile/states/auth_provider.dart';

import '../states/api_provider.dart';
import '../widgets/row_space.dart';

class LoginPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  label: Text("Email"),
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return "Please input email.";
                  }
                  return null;
                }),
              ),
              RowSpace(),
              TextFormField(
                  controller: _password,
                  decoration: InputDecoration(
                    label: Text("Password"),
                    border: OutlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        hidePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: hidePassword,
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return "Please input password.";
                    }
                    if (value.length < 2) {
                      return "Password must > 2";
                    }
                    return null;
                  })),
              RowSpace(),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      onLogin(context);
                    } else {
                      showWarning(context);
                    }
                  },
                  child: Text("Login")),
              RowSpace(
                height: 15,
              ),
              TextButton(
                onPressed: () => onRegister(context),
                child: Text("Or create new account"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Utility
  void showWarning(BuildContext context) {
    showDialog(
      context: context,
      builder: ((context) {
        return const AlertDialog(
          title: Text("Please input filed"),
          content: Text("Please validate all field"),
        );
      }),
    );
  }

  // Handler
  void onRegister(BuildContext context) {
    Navigator.of(context).pushNamed('/register');
  }

  void onLogin(BuildContext context) async {
    Map login = {};
    login["username"] = _email.text;
    login["password"] = _password.text;
    try {
      var dio = ref.read(apiProvider);
      var resp = await dio.post("/login", data: login);
      var respData = resp.data;
      dio.options.headers = {"Authorization": "Bearer ${respData['token']}"};
      ref.read(authProvider.notifier).state = AuthEnum.authorize;
    } catch (e) {
      print(e.toString());
      // TODO: show error
    }
  }
}
