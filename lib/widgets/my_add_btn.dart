import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_mobile/states/counter_state_provider.dart';

class MyAddBtn extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        onPressed: () {
          ref.read(counterStateProvider.notifier).state += 1;
        },
        child: const Text("Add count"));
  }
}
