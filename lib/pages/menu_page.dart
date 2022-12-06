import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_mobile/pages/my_home_page.dart';
import 'package:simple_mobile/pages/my_home_state_page.dart';
import 'package:simple_mobile/pages/my_river_page.dart';
import 'package:simple_mobile/states/menu_provider.dart';

import 'setting_page.dart';

class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  @override
  Widget build(Object context, WidgetRef ref) {
    return Scaffold(
      body: bodyWidget(ref.watch(menuIndexProvider)),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.feed), label: "News"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
        ],
        currentIndex: ref.watch(menuIndexProvider),
        onTap: ((value) {
          ref.read(menuIndexProvider.notifier).state = value;
        }),
      ),
    );
  }

  Widget bodyWidget(int currentIndex) {
    var mainWidget = [
      MyHomePage(),
      const MyRiverPage(),
      const SettingPage(),
    ];
    return mainWidget[currentIndex];
  }
}
