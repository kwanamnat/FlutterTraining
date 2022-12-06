import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_mobile/pages/login_page.dart';
import 'package:simple_mobile/pages/menu_page.dart';
import 'package:simple_mobile/states/auth_provider.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    if (auth == AuthEnum.unAuthorize) {
      return LoginPage();
    } else {
      return MenuPage();
    }
  }
}
