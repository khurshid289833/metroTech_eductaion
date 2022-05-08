import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/topCourses/model/topCoursesModel.dart';

class TopCoursesRepository {
  ApiBaseHelper _helper = ApiBaseHelper();
  Future<TopCoursesModel> TopCoursesRepositoryFunction(int pageno) async {
    final response = await _helper.get("api/top-courses?page=$pageno");
    return TopCoursesModel.fromJson(response);
  }
}