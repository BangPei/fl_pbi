import 'package:fl_pbi/models/models.dart';
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

  static Future<Transaction> post(Transaction ipl) async {
    final client = await Api.restClient();
    var data = client.postIPL(ipl);
    return data;
  }

  static Future<dynamic> delete(int id) async {
    final client = await Api.restClient();
    var data = client.removeIPL(id);
    return data;
  }

  static Future<Transaction> getId(int id) async {
    final client = await Api.restClient();
    var data = client.getIPLById(id);
    return data;
  }

  static Future<Transaction> put(Transaction ipl) async {
    final client = await Api.restClient();
    var data = client.putIPL(ipl.id, ipl);
    return data;
  }

  static Future<TransactionReport> getByDate(Map<String, dynamic> map) async {
    final client = await Api.restClient(params: map);
    var data = client.getIPLByDate();
    return data;
  }
}
