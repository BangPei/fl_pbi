import 'package:fl_pbi/models/number.dart';
import 'package:fl_pbi/pages/block/data/block.dart';
import 'package:fl_pbi/service/api.dart';

class BlockApi {
  static Future<dynamic> postNumber(Map<String, dynamic> body) async {
    final client = await Api.restClient();
    var data = client.postNumber(body);
    return data;
  }

  static Future<List<Number>> getNumbers() async {
    final client = await Api.restClient();
    var data = client.getNumbers();
    return data;
  }

  static Future<List<Block>> getBlocks() async {
    final client = await Api.restClient();
    var data = client.getBlocks();
    return data;
  }

  static Future<Block> getBlock(String id) async {
    final client = await Api.restClient();
    var data = client.getBlockById(id);
    return data;
  }

  static Future<Block> postBlock(Map<String, dynamic> body) async {
    final client = await Api.restClient();
    var data = client.postBlock(body);
    return data;
  }

  static Future<Block> putBlock(Map<String, dynamic> body) async {
    final client = await Api.restClient();
    var data = client.putBlock(body['id'], body);
    return data;
  }
}