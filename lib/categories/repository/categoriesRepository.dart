import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/categories/model/categoriesModel.dart';

class CategoriesRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<CategoriesModel> getCategories() async {
    final response = await _helper.get("api/display-cat-sub-topic");
    return CategoriesModel.fromJson(response);
  }
}
