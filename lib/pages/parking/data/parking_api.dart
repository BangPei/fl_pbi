import 'package:fl_pbi/models/models.dart';
import 'package:fl_pbi/service/api.dart';

class ParkingApi {
  static Future<CashFlow> getTotal() async {
    final client = await Api.restClient();
    var data = client.getTotal();
    return data;
  }

  static Future<ServerSide> get({Map<String, dynamic>? params}) async {
    final client = await Api.restClient(params: params);
    var data = client.getParkingList();
    return data;
  }

  static Future<Transaction> post(Transaction park) async {
    final client = await Api.restClient();
    var data = client.postParking(park);
    return data;
  }

  static Future<dynamic> delete(int id) async {
    final client = await Api.restClient();
    var data = client.removeParking(id);
    return data;
  }

  static Future<Transaction> getId(int id) async {
    final client = await Api.restClient();
    var data = client.getParkingById(id);
    return data;
  }

  static Future<Transaction> put(Transaction parking) async {
    final client = await Api.restClient();
    var data = client.putParking(parking.id, parking);
    return data;
  }

  static Future<List<Trans>> getyearly(String year, String type) async {
    final client = await Api.restClient();
    var data = client.getParkingYearly(year, type);
    return data;
  }

  static Future<TransactionReport> getByDate(Map<String, dynamic> map) async {
    final client = await Api.restClient(params: map);
    var data = client.getParkingByDate();
    return data;
  }
}
