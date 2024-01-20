import 'package:fl_pbi/pages/finance/data/finance.dart';
import 'package:fl_pbi/service/api.dart';

class FinanceApi {
  static Future<Finance> getTotal() async {
    final client = await Api.restClient();
    var data = client.getFinanceTotal();
    return data;
  }
}
