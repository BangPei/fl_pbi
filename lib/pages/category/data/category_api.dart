import 'package:fl_pbi/pages/category/data/category.dart';
import 'package:fl_pbi/service/api.dart';

class CategoryApi {
  static Future<Category> post(Category category) async {
    final client = await Api.restClient();
    var data = client.postCategory(category);
    return data;
  }

  static Future<List<Category>> get() async {
    final client = await Api.restClient();
    var data = client.getCategory();
    return data;
  }

  static Future<Category> getById(int id) async {
    final client = await Api.restClient();
    var data = client.getCategoryById(id);
    return data;
  }

  static Future<Category> put(Category category) async {
    final client = await Api.restClient();
    var data = client.putCategory(category.id, category);
    return data;
  }
}
