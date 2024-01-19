import 'package:dio/dio.dart';
import 'package:fl_pbi/models/number.dart';
import 'package:fl_pbi/models/serverside.dart';
import 'package:fl_pbi/pages/block/data/block.dart';
import 'package:fl_pbi/pages/ipl/data/ipl.dart';
import 'package:fl_pbi/pages/login/data/login.dart';
import 'package:fl_pbi/models/cash_flow.dart';
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

  @POST("number")
  Future<dynamic> postNumber(@Body() Map<String, dynamic> body);

  @GET("number")
  Future<List<Number>> getNumbers();

  @GET("block")
  Future<List<Block>> getBlocks();

  @GET("block/{id}")
  Future<Block> getBlockById(@Path() String id);

  @POST("block")
  Future<Block> postBlock(@Body() Map<String, dynamic> body);

  @PUT("block/{id}")
  Future<Block> putBlock(@Path() int id, @Body() Map<String, dynamic> body);

  @GET("ipl")
  Future<ServerSide> getIPLList();

  @GET("ipl/{id}")
  Future<IPL> getIPLById(@Path() int id);

  @DELETE("ipl/{id}")
  Future<dynamic> removeIPL(@Path() int id);

  @GET("ipl/total")
  Future<CashFlow> getIplTotal();

  @POST("ipl")
  Future<IPL> postIPL(@Body() Parking park);

  @PUT("ipl/{id}")
  Future<IPL> putIPL(@Path() int id, @Body() Parking park);
}
