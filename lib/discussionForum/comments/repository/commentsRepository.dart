import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/discussionForum/comments/model/commentsModel.dart';

class CommentsRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<CommentsModel> CommentsRepositoryFunction(body, String token) async {
    final response = await _helper.postWithHeader("api/post-comment", body, "Bearer " + token);
    return CommentsModel.fromJson(response);
  }
}
