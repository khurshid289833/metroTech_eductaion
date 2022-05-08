import 'dart:async';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/discussionForum/reply/model/replyModel.dart';
import 'package:metrotech_education/discussionForum/reply/repository/replyRepository.dart';

class ReplyBloc {

  ReplyRepository _replyRepository;
  StreamController _streamController;

  StreamSink<ApiResponse<ReplyModel>> get replySink => _streamController.sink;
  Stream<ApiResponse<ReplyModel>> get replyStream => _streamController.stream;

  ReplyBloc() {
    _streamController = StreamController<ApiResponse<ReplyModel>>.broadcast();
    _replyRepository = ReplyRepository();
  }
  ReplyBlocFunction(body, String token) async {
    replySink.add(ApiResponse.loading("Fetching",));
    try {
      ReplyModel response = await _replyRepository.ReplyRepositoryFunction(body, token);
      replySink.add(ApiResponse.completed(response));
    } catch (e) {
      replySink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _streamController?.close();
  }
}