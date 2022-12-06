import 'package:flutter/material.dart';
import '/widgets/my_add_btn.dart';
import '/widgets/my_counter.dart';

class MyRiverPage extends StatelessWidget {
  const MyRiverPage({super.key});

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My River")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MyAddBtn(),
          MyCounter(),
        ],
      ),
    );
  }
}
