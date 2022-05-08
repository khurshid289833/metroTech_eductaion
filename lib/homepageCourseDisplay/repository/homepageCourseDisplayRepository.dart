import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/homepageCourseDisplay/model/homepageCourseDisplayModel.dart';

class HomepageCourseDisplayRepository {
  ApiBaseHelper _helper = ApiBaseHelper();
  Future<HomepageCourseDisplayModel> HomepageCourseDisplayRepositoryFunction(int pageno) async {
    final response = await _helper.get("api/homepage-course-display?page=$pageno");
    return HomepageCourseDisplayModel.fromJson(response);
  }
}