import 'package:flutter/material.dart';

class MyHomeState extends StatefulWidget {
  const MyHomeState({super.key});

  @override
  State<MyHomeState> createState() => _MyHomeStateState();
}

class _MyHomeStateState extends State<MyHomeState> {
  int counter = 0;

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
          setState(() {
            counter += 1;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
