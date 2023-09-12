import 'package:fl_pbi/screen/profile/data/profile.dart';
import 'package:fl_pbi/service/api.dart';

class ProfileAPI {
  static Future<Profile> getCurrentProfile() async {
    final client = await Api.restClient();
    var data = client.getCurrentProfile();
    return data;
  }
}
