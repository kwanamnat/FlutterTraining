import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '/states/counter_state_provider.dart';

class MyCounter extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int counter = ref.watch(counterStateProvider);
    return Text("$counter");
  }
}
