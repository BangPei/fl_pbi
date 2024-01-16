import 'package:fl_pbi/service/api.dart';

class BlockApi {
  static Future<dynamic> postNumber(Map<String, dynamic> body) async {
    final client = await Api.restClient();
    var data = client.postNumber(body);
    return data;
  }
}
