import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/course/model/listOfCoursesModel.dart';

class ListOfCoursesRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<ListOfCoursesModel> getCourse(String catid, String subcatid, String topid) async {
    final response = await _helper.get("api/display-course?category_id=$catid&sub_category_id=$subcatid&topic_id=$topid");
    return ListOfCoursesModel.fromJson(response);
  }
}
