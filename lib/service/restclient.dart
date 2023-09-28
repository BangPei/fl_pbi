import 'package:dio/dio.dart';
import 'package:fl_pbi/screen/login/data/login.dart';
import 'package:fl_pbi/screen/profile/data/profile.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

part 'restclient.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("login")
  Future<HttpResponse> login(@Body() Login login);

  @DELETE("logout")
  Future<dynamic> logout();

  @GET("profile")
  Future<Profile> getCurrentProfile();

  @PUT("profile/{id}")
  Future<Profile> putProfile(@Path() int id, @Body() Profile profile);

  // @GET("sales/{id}")
  // Future<Salesman> salesmanFindById(@Path() String id);

  // @GET("customer")
  // Future<List<Customer>> findAllCustomer();

  // @GET("customer/{id}")
  // Future<Customer> customerFindById(@Path() String id);
}
