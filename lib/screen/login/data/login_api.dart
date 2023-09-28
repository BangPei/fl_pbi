import 'package:fl_pbi/screen/login/data/login.dart';
import 'package:fl_pbi/service/api.dart';
import 'package:retrofit/dio.dart';

class LoginApi {
  static Future<HttpResponse> login(Login login) async {
    final client = await Api.restClient();
    var data = client.login(login);
    return data;
  }

  static Future<dynamic> logout() async {
    final client = await Api.restClient();
    var data = client.logout();
    return data;
  }
}
