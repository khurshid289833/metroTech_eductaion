import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/homepagePrivateClassListing/model/homepagePrivateClassListingModel.dart';

class HomepagePrivateClassListingRepository {
  ApiBaseHelper _helper = ApiBaseHelper();
  Future<HomepagePrivateClassListingModel> HomepagePrivateClassListingRepositoryFunction() async {
    final response = await _helper.get("api/private-class-listing-for-all");
    return HomepagePrivateClassListingModel.fromJson(response);
  }
}