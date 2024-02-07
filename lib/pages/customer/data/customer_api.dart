import 'package:fl_pbi/models/models.dart';
import 'package:fl_pbi/pages/profile/data/profile.dart';
import 'package:fl_pbi/service/api.dart';

class CustomerApi {
  static Future<Profile> post(Profile profile) async {
    final client = await Api.restClient();
    var data = client.postCustomer(profile);
    return data;
  }

  static Future<ServerSide> get({Map<String, dynamic>? params}) async {
    final client = await Api.restClient(params: params);
    var data = client.getCustomer();
    return data;
  }

  static Future<Profile> getById(int id) async {
    final client = await Api.restClient();
    var data = client.getCustomerById(id);
    return data;
  }

  static Future<Profile> put(Profile profile) async {
    final client = await Api.restClient();
    var data = client.putCustomer(profile.id, profile);
    return data;
  }
}
