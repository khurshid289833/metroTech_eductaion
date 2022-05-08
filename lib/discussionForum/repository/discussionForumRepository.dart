import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/discussionForum/model/discussionForumModel.dart';

class DiscussionForumRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<DiscusssionForumModel> DiscussionForumRepositoryFunction(body,String token) async {
    final response = await _helper.postWithHeader("api/discussion-forum",body,"Bearer " + token);
    return DiscusssionForumModel.fromJson(response);
  }
}
