import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:simple_mobile/states/api_provider.dart';

import '../widgets/row_space.dart';

class RegisterPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return Register();
  }
}

class Register extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  var sex = 1;
  var isSubscribe = false;
  var ageRange = 1;
  var provinces = [
    Province(code: "-", label: "Please select province"),
    Province(code: "01", label: "Bangkok"),
    Province(code: "02", label: "Phisanulok"),
    Province(code: "03", label: "Nonthaburi"),
  ];

  var province = "-";
  var dobControler = TextEditingController();
  var _name = TextEditingController();
  var _code = TextEditingController();
  var _email = TextEditingController();
  var _pwd = TextEditingController();

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15),
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
                sexInput(),
                const RowSpace(),
                subscribeInput(),
                const RowSpace(),
                ageInput(),
                const RowSpace(),
                provinceInput(),
                const RowSpace(),
                dobInput(),
                const RowSpace(),
                registerBtn(),
                const RowSpace(),
                imageInputBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton registerBtn() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          onRegister();
        } else {
          // TODO: show warning
        }
      },
      child: Text("Register"),
    );
  }

  void onRegister() async {
    var register = {};
    register["code"] = _code.text;
    register["name"] = _name.text;
    register["email"] = _email.text;
    register["pwd"] = _pwd.text;
    try {
      var dio = ref.read(apiProvider);
      var resp = await dio.post("/register", data: register);
      var respData = resp.data;
      Navigator.of(context).pop();
    } catch (e) {
      // TODO: show error
      print(e.toString());
    }
  }

  TextFormField nameInput() {
    return TextFormField(
      controller: _name,
      decoration: InputDecoration(
        label: Text("Name"),
      ),
      validator: ((value) {
        if (value!.isEmpty) {
          return "Please input name";
        }
        if (value.length < 5) {
          return "Name must be > 5";
        }
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
      }),
    );
  }

  TextFormField pwdConfirmInput() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        label: Text("Confirm Password"),
      ),
      validator: ((value) {
        if (value!.isEmpty) {
          return "Please input re-password";
        }
        if (value != _pwd.text) {
          return "Password mismatch !!!";
        }
        return null;
      }),
    );
  }

  Widget sexInput() {
    return Row(
      children: [
        Radio(
          value: 1,
          groupValue: sex,
          onChanged: (value) {
            setState(() {
              sex = value ?? 0;
            });
          },
        ),
        const Text("Male"),
        Radio(
          value: 2,
          groupValue: sex,
          onChanged: (value) {
            setState(() {
              sex = value ?? 0;
            });
          },
        ),
        const Text("Female"),
      ],
    );
  }

  Widget subscribeInput() {
    return Row(
      children: [
        Checkbox(
          value: isSubscribe,
          onChanged: (value) {
            setState(
              () {
                isSubscribe = value ?? false;
              },
            );
          },
        ),
        const Text("Subscribe news feed ?"),
      ],
    );
  }

  Widget ageInput() {
    return DropdownButtonFormField(
      items: const [
        DropdownMenuItem(
          value: 1,
          child: Text("1 - 10"),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text("11 - 20"),
        ),
      ],
      value: ageRange,
      onChanged: (value) {
        setState(() {
          ageRange = value ?? 0;
        });
      },
    );
  }

  Widget provinceInput() {
    return DropdownButtonFormField<String>(
      value: province,
      onChanged: (value) {
        setState(() {
          province = value ?? "";
        });
      },
      items: provinces
          .map(
            (e) => DropdownMenuItem(
              value: e.code,
              child: Text(e.label),
            ),
          )
          .toList(),
    );
  }

  Widget dobInput() {
    return TextFormField(
      controller: dobControler,
      decoration: InputDecoration(
        label: const Text("DOB"),
        suffix: IconButton(
          icon: const Icon(Icons.calendar_month),
          onPressed: () async {
            var now = DateTime.now();
            var result = await showDatePicker(
              context: context,
              initialDate: now,
              firstDate: DateTime(now.year - 100),
              lastDate: DateTime(now.year + 10),
            );
            var df = DateFormat("dd/MM/yyyy");
            dobControler.text = df.format(result!);
          },
        ),
      ),
    );
  }

  imageInput() async {
    var img = await ImagePicker.platform.getImage(source: ImageSource.camera);
  }

  Widget imageInputBtn() {
    return ElevatedButton(
      onPressed: () {
        imageInput();
      },
      child: const Text("Browse Image"),
    );
  }
}
// Model

class Province {
  final String code;
  final String label;

  Province({required this.code, required this.label});
}
