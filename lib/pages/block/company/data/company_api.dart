import 'package:fl_pbi/pages/block/company/data/company.dart';
import 'package:fl_pbi/service/api.dart';

class CompanyApi {
  static Future<List<Company>> get() async {
    final client = await Api.restClient();
    var data = client.getCompany();
    return data;
  }

  static Future<Company> getById(int id) async {
    final client = await Api.restClient();
    var data = client.getCompanyById();
    return data;
  }
}
