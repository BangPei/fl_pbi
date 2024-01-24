import 'package:fl_pbi/models/cash_flow.dart';
import 'package:fl_pbi/models/serverside.dart';
import 'package:fl_pbi/models/trans.dart';
import 'package:fl_pbi/pages/ipl/data/ipl.dart';
import 'package:fl_pbi/service/api.dart';

class IplApi {
  static Future<CashFlow> getTotal() async {
    final client = await Api.restClient();
    var data = client.getIplTotal();
    return data;
  }

  static Future<List<Trans>> getyearly(String year, String type) async {
    final client = await Api.restClient();
    var data = client.getIplYearly(year, type);
    return data;
  }

  static Future<ServerSide> get({Map<String, dynamic>? params}) async {
    final client = await Api.restClient(params: params);
    var data = client.getIPLList();
    return data;
  }

  static Future<IPL> post(IPL ipl) async {
    final client = await Api.restClient();
    var data = client.postIPL(ipl);
    return data;
  }

  static Future<dynamic> delete(int id) async {
    final client = await Api.restClient();
    var data = client.removeIPL(id);
    return data;
  }

  static Future<IPL> getId(int id) async {
    final client = await Api.restClient();
    var data = client.getIPLById(id);
    return data;
  }

  static Future<IPL> put(IPL ipl) async {
    final client = await Api.restClient();
    var data = client.putIPL(ipl.id, ipl);
    return data;
  }
}
