import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final apiProvider = Provider((ref) {
  var dio = Dio(
    BaseOptions(
      baseUrl: const String.fromEnvironment("baseUrl",
          defaultValue: "http://103.212.37.63:8000/api"),
    ),
  );

  return dio;
});
