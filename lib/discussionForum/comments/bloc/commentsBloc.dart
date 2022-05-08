import 'dart:async';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/discussionForum/comments/model/commentsModel.dart';
import 'package:metrotech_education/discussionForum/comments/repository/commentsRepository.dart';

class CommentsBloc {

  CommentsRepository _commentsRepository;
  StreamController _streamController;

  StreamSink<ApiResponse<CommentsModel>> get commentsSink => _streamController.sink;
  Stream<ApiResponse<CommentsModel>> get commentsStream => _streamController.stream;

  CommentsBloc() {
    _streamController = StreamController<ApiResponse<CommentsModel>>.broadcast();
    _commentsRepository = CommentsRepository();
  }
  CommentsBlocFunction(body, String token) async {
    commentsSink.add(ApiResponse.loading("Fetching",));
    try {
      CommentsModel response = await _commentsRepository.CommentsRepositoryFunction(body, token);
      commentsSink.add(ApiResponse.completed(response));
    } catch (e) {
      commentsSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _streamController?.close();
  }
}