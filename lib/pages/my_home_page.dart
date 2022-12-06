import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  int counter = 0;
  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Press times"),
            Text("$counter"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter += 1;
          print(counter);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
