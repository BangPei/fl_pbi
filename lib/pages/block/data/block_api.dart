import 'package:fl_pbi/models/models.dart';
import 'package:fl_pbi/pages/block/data/block.dart';
import 'package:fl_pbi/pages/block/data/block_details.dart';
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

  static Future<List<Block>> getBlocks({Map<String, dynamic>? params}) async {
    final client = await Api.restClient(params: params);
    var data = client.getBlocks();
    return data;
  }

  static Future<Block> getBlock(String id) async {
    final client = await Api.restClient();
    var data = client.getBlockById(id);
    return data;
  }

  static Future<Block> postBlock(Block blok) async {
    final client = await Api.restClient();
    var data = client.postBlock(blok);
    return data;
  }

  static Future<Block> putBlock(Block block) async {
    final client = await Api.restClient();
    var data = client.putBlock(block.id, block);
    return data;
  }

  static Future<BlockDetail> getBlockDetail(int id) async {
    final client = await Api.restClient();
    var data = client.getBlockDetailById(id);
    return data;
  }

  static Future<List<BlockDetail>> getBlockDetails() async {
    final client = await Api.restClient();
    var data = client.getBlockDetails();
    return data;
  }
}
