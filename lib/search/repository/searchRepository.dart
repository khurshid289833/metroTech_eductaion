import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/search/model/searchModel.dart';

class SearchRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<SearchModel> SearchRepositoryFunction(String searchValue) async {
    final response = await _helper.get("api/course-search?search=$searchValue");
    return SearchModel.fromJson(response);
  }
}