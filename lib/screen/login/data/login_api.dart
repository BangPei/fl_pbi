import 'package:fl_pbi/screen/login/data/login.dart';
import 'package:fl_pbi/service/api.dart';

class LoginApi {
  static Future<dynamic> login(Login login) async {
    final client = await Api.restClient();
    var data = client.login(login);
    return data;
  }
}
