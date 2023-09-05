import 'package:dio/dio.dart';
import 'package:fl_pbi/injector/dio_interceptor.dart';
import 'package:fl_pbi/service/restclient.dart';

class Api {
  // static const String baseUrl = "http://192.168.0.163:3000/api/";
  static const String baseUrl = "http://192.168.100.11:3000/api/";

  static restClient() async {
    final dio = Dio();
    dio.interceptors.clear();
    dio.interceptors.add(DioInterceptors(dio));
    // dio.options.headers["Authorization"] = await Session.get("authorization");
    return RestClient(dio, baseUrl: baseUrl);
  }
}
