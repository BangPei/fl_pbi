import 'package:fl_pbi/models/serverside.dart';
import 'package:fl_pbi/pages/parking/data/cash_flow.dart';
import 'package:fl_pbi/service/api.dart';

class ParkingApi {
  static Future<CashFlow> getTotal() async {
    final client = await Api.restClient();
    var data = client.getTotal();
    return data;
  }

  static Future<ServerSide> get() async {
    final client = await Api.restClient();
    var data = client.getParkingList();
    return data;
  }
}
