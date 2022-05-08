import 'package:metrotech_education/api_base/api_base_helper.dart';
import 'package:metrotech_education/discussionForum/reply/model/replyModel.dart';

class ReplyRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<ReplyModel> ReplyRepositoryFunction(body, String token) async {
    final response = await _helper.postWithHeader("api/post-reply", body, "Bearer " + token);
    return ReplyModel.fromJson(response);
  }
}
