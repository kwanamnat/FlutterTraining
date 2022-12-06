import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_mobile/states/api_provider.dart';

final userDataProvider = StateProvider((ref) => []);
final userRepoProvider = Provider((ref) => UserRepository(ref));

class UserRepository {
  final Ref ref;
  UserRepository(this.ref);

  void listAllUser() async {
    var dio = ref.read(apiProvider);
    try {
      var resp = await dio.get("/user");
      var respData = resp.data;
      ref.read(userDataProvider.notifier).state = respData;
    } on DioError catch (e) {
      // TODO: handle dio error
    } catch (e) {
      // TODO: handler exception
    }
  }

  Future<bool> createNewUser(Map user) async {
    var dio = ref.read(apiProvider);
    try {
      await dio.post("/user", data: user);
      return true;
    } on DioError catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteUser(int id) async {
    var dio = ref.read(apiProvider);
    try {
      await dio.delete("/user/$id");
      return true;
    } on DioError catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }
}
