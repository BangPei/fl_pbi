import 'package:dio/dio.dart';
import 'package:fl_pbi/models/models.dart';
import 'package:fl_pbi/pages/block/company/data/company.dart';
import 'package:fl_pbi/pages/block/data/block.dart';
import 'package:fl_pbi/pages/block/data/block_details.dart';
import 'package:fl_pbi/pages/category/data/category.dart';
import 'package:fl_pbi/pages/finance/data/finance.dart';
import 'package:fl_pbi/pages/login/data/login.dart';
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
  Future<Transaction> getParkingById(@Path() int id);

  @DELETE("transaction/{id}")
  Future<dynamic> removeParking(@Path() int id);

  @GET("transaction/total")
  Future<CashFlow> getTotal();

  @POST("transaction")
  Future<Transaction> postParking(@Body() Transaction park);

  @PUT("transaction/{id}")
  Future<Transaction> putParking(@Path() int id, @Body() Transaction park);

  @POST("number")
  Future<dynamic> postNumber(@Body() Map<String, dynamic> body);

  @GET("number")
  Future<List<Number>> getNumbers();

  @GET("block-detail")
  Future<List<BlockDetail>> getBlockDetails();

  @GET("block-detail/{id}")
  Future<BlockDetail> getBlockDetailById(@Path() int id);

  @GET("block")
  Future<List<Block>> getBlocks();

  @GET("block/{id}")
  Future<Block> getBlockById(@Path() String id);

  @POST("block")
  Future<Block> postBlock(@Body() Block block);

  @PUT("block/{id}")
  Future<Block> putBlock(@Path() int id, @Body() Block block);

  @GET("ipl")
  Future<ServerSide> getIPLList();

  @GET("ipl/{id}")
  Future<Transaction> getIPLById(@Path() int id);

  @DELETE("ipl/{id}")
  Future<dynamic> removeIPL(@Path() int id);

  @GET("ipl/total")
  Future<CashFlow> getIplTotal();

  @POST("ipl")
  Future<Transaction> postIPL(@Body() Transaction park);

  @PUT("ipl/{id}")
  Future<Transaction> putIPL(@Path() int id, @Body() Transaction park);

  @GET("finance/total")
  Future<Finance> getFinanceTotal();

  @GET("ipl/yearly/{year}/type/{type}")
  Future<List<Trans>> getIplYearly(@Path() String year, @Path() String type);

  @GET("transaction/yearly/{year}/type/{type}")
  Future<List<Trans>> getParkingYearly(
      @Path() String year, @Path() String type);

  @GET("transaction/date")
  Future<TransactionReport> getParkingByDate();

  @GET("ipl/date")
  Future<TransactionReport> getIPLByDate();

  @GET("customer")
  Future<ServerSide> getCustomer();

  @GET("customer/{id}")
  Future<Profile> getCustomerById(@Path() int id);

  @POST("customer}")
  Future<Profile> postCustomer(@Body() Profile profile);

  @PUT("customer}")
  Future<Profile> putCustomer(@Path() int id, @Body() Profile profile);

  @GET("category")
  Future<List<Category>> getCategory();

  @GET("category/{id}")
  Future<Category> getCategoryById(@Path() int id);

  @POST("category}")
  Future<Category> postCategory(@Body() Category category);

  @PUT("category}")
  Future<Profile> putCategory(@Path() int id, @Body() Category category);

  @GET("company")
  Future<List<Company>> getCompany();

  @GET("company/{id}")
  Future<Company> getCompanyById(@Path() int id);
}
