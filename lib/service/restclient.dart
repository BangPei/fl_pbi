import 'package:dio/dio.dart';
import 'package:fl_pbi/screen/login/data/login.dart';
import 'package:retrofit/http.dart';

part 'restclient.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("auth")
  Future<dynamic> login(@Body() Login login);

  @DELETE("users/logout")
  Future<dynamic> logout();

  // @GET("sales/{id}")
  // Future<Salesman> salesmanFindById(@Path() String id);

  // @GET("customer")
  // Future<List<Customer>> findAllCustomer();

  // @GET("customer/{id}")
  // Future<Customer> customerFindById(@Path() String id);
}
