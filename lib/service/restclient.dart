import 'package:dio/dio.dart';
import 'package:fl_pbi/models/serverside.dart';
import 'package:fl_pbi/pages/login/data/login.dart';
import 'package:fl_pbi/pages/parking/data/cash_flow.dart';
import 'package:fl_pbi/pages/parking/data/parking.dart';
import 'package:fl_pbi/pages/profile/data/profile.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

part 'restclient.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("login")
  Future<HttpResponse> login(@Body() Login login);

  @POST("password/change")
  Future<dynamic> changePassword(@Body() Map<String, dynamic> pass);

  @DELETE("logout")
  Future<dynamic> logout();

  @GET("profile")
  Future<Profile> getCurrentProfile();

  @PUT("profile/{id}")
  Future<Profile> putProfile(@Path() int id, @Body() Profile profile);

  @GET("transaction")
  Future<ServerSide> getParkingList();

  @GET("transaction/{id}")
  Future<Parking> getParkingById(@Path() int id);

  @DELETE("transaction/{id}")
  Future<dynamic> removeParking(@Path() int id);

  @GET("transaction/total")
  Future<CashFlow> getTotal();

  @POST("transaction")
  Future<Parking> postParking(@Body() Parking park);

  @PUT("transaction/{id}")
  Future<Parking> putParking(@Path() int id, @Body() Parking park);
  // @GET("sales/{id}")
  // Future<Salesman> salesmanFindById(@Path() String id);

  // @GET("customer")
  // Future<List<Customer>> findAllCustomer();

  // @GET("customer/{id}")
  // Future<Customer> customerFindById(@Path() String id);
}
