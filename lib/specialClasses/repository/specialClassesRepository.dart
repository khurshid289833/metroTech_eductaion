import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/specialClasses/model/specialClassesModel.dart';

class SpecialClassesRepository {
  ApiBaseHelper _helper = ApiBaseHelper();
  Future<SpecialClassesModel> SpecialClassesRepositoryFunction(String token) async {
    final response = await _helper.getWithHeader("api/private-class-listing","Bearer " + token);
    return SpecialClassesModel.fromJson(response);
  }
}