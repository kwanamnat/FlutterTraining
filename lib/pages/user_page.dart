import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_mobile/states/user_provider.dart';

class UserPage extends ConsumerWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User"),
      ),
      body: createList(ref, ref.watch(userDataProvider)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onAdd(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget createList(WidgetRef ref, List data) {
    return ListView.builder(
      itemBuilder: ((context, index) {
        var d = data[index];
        return ListTile(
          title: Text(d["name"]),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              onDelete(context, ref, d["id"]);
            },
          ),
        );
      }),
      itemCount: data.length,
    );
  }

  void onDelete(BuildContext context, WidgetRef ref, int id) {
    showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: const Text("Please confirm"),
            content: const Text("Are you sure to delete ?"),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    var resp = await ref.read(userRepoProvider).deleteUser(id);
                    if (resp) {
                      Navigator.of(context).pop();
                      ref.read(userRepoProvider).listAllUser();
                    }
                  },
                  child: const Text("Yes")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("No")),
            ],
          )),
    );
  }

  void onAdd(BuildContext context) {
    Navigator.of(context).pushNamed("/user-form");
  }
}
