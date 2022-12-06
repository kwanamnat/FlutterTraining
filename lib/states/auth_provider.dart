import 'package:hooks_riverpod/hooks_riverpod.dart';

enum AuthEnum { unAuthorize, authorize }

final authProvider = StateProvider((ref) => AuthEnum.unAuthorize);
