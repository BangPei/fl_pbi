import 'package:dio/dio.dart';
import 'package:fl_pbi/injector/dio_interceptor.dart';
import 'package:fl_pbi/library/session_manager.dart';
import 'package:fl_pbi/service/restclient.dart';

class Api {
  // static const String baseUrl = "http://192.168.0.163:3000/api/";
  // static const String baseUrl = "http://192.168.1.7:3000/api/";
  static const String baseUrl = "https://api.perniagaan-pbi.com/api/";

  static restClient({Map<String, dynamic>? params}) async {
    final dio = Dio();
    dio.interceptors.clear();
    dio.interceptors.add(DioInterceptors(dio));
    dio.options.headers["Authorization"] = await Session.get("token");
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.headers["Accept"] = "*/*";
    dio.options.queryParameters = params ?? {};
    return RestClient(dio, baseUrl: baseUrl);
  }
}
