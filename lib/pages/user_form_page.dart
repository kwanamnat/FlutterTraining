import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_mobile/states/user_provider.dart';

import '../widgets/row_space.dart';

class UserFormPage extends ConsumerStatefulWidget {
  const UserFormPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return UserFormPageState();
  }
}

class UserFormPageState extends ConsumerState {
  final _name = TextEditingController();
  final _code = TextEditingController();
  final _email = TextEditingController();
  final _pwd = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Form"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                codeInput(),
                const RowSpace(),
                nameInput(),
                const RowSpace(),
                emailInput(),
                const RowSpace(),
                pwdInput(),
                const RowSpace(),
                saveBtn(context, ref),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton saveBtn(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          onSave(context, ref);
        } else {
          // TODO: show warning
        }
      },
      child: const Text("Save"),
    );
  }

  void onSave(BuildContext context, WidgetRef ref) async {
    var register = {};
    register["code"] = _code.text;
    register["name"] = _name.text;
    register["email"] = _email.text;
    register["pwd"] = _pwd.text;
    var resp = await ref.read(userRepoProvider).createNewUser(register);
    if (resp) {
      ref.read(userRepoProvider).listAllUser();
      Navigator.of(context).pop();
    } else {
      // TODO: show warning
    }
  }

  TextFormField nameInput() {
    return TextFormField(
      controller: _name,
      decoration: const InputDecoration(
        label: Text("Name"),
      ),
      validator: ((value) {
        if (value!.isEmpty) {
          return "Please input name";
        }
        if (value.length < 5) {
          return "Name must be > 5";
        }
        return null;
      }),
    );
  }

  TextFormField codeInput() {
    return TextFormField(
      controller: _code,
      decoration: const InputDecoration(
        label: Text("Code"),
      ),
      validator: ((value) {
        if (value!.isEmpty) {
          return "Please input code";
        }
        if (value.length > 5) {
          return "Name must be < 5";
        }
        return null;
      }),
    );
  }

  TextFormField emailInput() {
    return TextFormField(
      controller: _email,
      decoration: const InputDecoration(
        label: Text("EMail"),
      ),
      validator: ((value) {
        if (value!.isEmpty) {
          return "Please input email";
        }
        return null;
      }),
    );
  }

  TextFormField pwdInput() {
    return TextFormField(
      controller: _pwd,
      obscureText: true,
      decoration: const InputDecoration(
        label: Text("Password"),
      ),
      validator: ((value) {
        if (value!.isEmpty) {
          return "Please input password";
        }
        return null;
      }),
    );
  }
}
