import 'package:fl_pbi/models/serverside.dart';
import 'package:fl_pbi/pages/parking/data/cash_flow.dart';
import 'package:fl_pbi/pages/parking/data/parking.dart';
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

  static Future<Parking> post(Parking park) async {
    final client = await Api.restClient();
    var data = client.postParking(park);
    return data;
  }

  static Future<dynamic> delete(int id) async {
    final client = await Api.restClient();
    var data = client.removeParking(id);
    return data;
  }

  static Future<Parking> getId(int id) async {
    final client = await Api.restClient();
    var data = client.getParkingById(id);
    return data;
  }

  static Future<Parking> put(Parking parking) async {
    final client = await Api.restClient();
    var data = client.putParking(parking.id, parking);
    return data;
  }
}
