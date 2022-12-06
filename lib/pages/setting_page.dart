import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_mobile/states/auth_provider.dart';
import 'package:simple_mobile/states/user_provider.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          createList(context, ref),
          creatSignOutBtn(ref),
        ],
      ),
    );
  }

  Widget creatSignOutBtn(WidgetRef ref) {
    return ElevatedButton(
        onPressed: () {
          ref.read(authProvider.notifier).state = AuthEnum.unAuthorize;
        },
        child: const Text("Signout"));
  }

  Widget createList(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ListView(
        children: [
          ListTile(
            title: const Text("User"),
            subtitle: const Text("Add / Edit / Remove User "),
            leading: const Icon(Icons.person),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              ref.read(userRepoProvider).listAllUser();
              Navigator.of(context).pushNamed("/user");
            },
          ),
          const Divider(),
          const ListTile(
            title: Text("Subject"),
            subtitle: Text("Add / Edit / Remove Subject "),
            leading: Icon(Icons.subject),
            trailing: Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }
}
