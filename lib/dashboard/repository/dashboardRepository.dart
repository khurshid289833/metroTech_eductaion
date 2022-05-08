import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/dashboard/model/dashboardModel.dart';

class DashboardRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<DashboardModel> DashboardRepositoryFunction(String token) async {
    final response = await _helper.getWithHeader("api/student-dashboard","Bearer " + token);
    return DashboardModel.fromJson(response);
  }
}