import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/discussionForum/comments/bloc/commentsBloc.dart';
import 'package:metrotech_education/discussionForum/comments/model/commentsModel.dart';
import 'package:metrotech_education/discussionForum/model/discussionForumModel.dart';
import 'package:metrotech_education/discussionForum/reply/bloc/replyBloc.dart';
import 'package:metrotech_education/discussionForum/reply/model/replyModel.dart';
import 'package:metrotech_education/discussionForum/repository/discussionForumRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:metrotech_education/constants.dart';

class DiscussionForum extends StatefulWidget {
  final course_id;
  DiscussionForum(this.course_id);

  @override
  _DiscussionForumState createState() => _DiscussionForumState(course_id);
}

class _DiscussionForumState extends State<DiscussionForum> {
  final course_id;
  _DiscussionForumState(this.course_id);


  TextEditingController commentController = TextEditingController();
  TextEditingController replyController = TextEditingController();
  CommentsBloc _commentsBloc;
  ReplyBloc _replyBloc;

  final _formKey = GlobalKey<FormState>();
  String token = "";
  bool streamCheck = false;
  SharedPreferences prefs;
  List visibilityViewReply=[];
  List visibilityReply=[];

   Future<DiscusssionForumModel> _discussionForumFuture;
   DiscussionForumRepository _discussionForumRepository;

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString("access_token");
    Map body = {
      "course_id":course_id.toString()
    };
    _discussionForumRepository = DiscussionForumRepository();
    _discussionForumFuture = _discussionForumRepository.DiscussionForumRepositoryFunction(body, token);
    setState(() {});
  }

  @override
  void initState() {
    createSharedPref();
    _commentsBloc = CommentsBloc();
    _replyBloc = ReplyBloc();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(h * 0.08),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
              icon:
              Icon(Icons.arrow_back_rounded, color: Colors.black, size: 25),
              onPressed: () {
                Navigator.pop(context);
              }),
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.only(top: 8),
            child: Image.asset(
              'images/logo.png',
              fit: BoxFit.contain,
              height: 35,
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.03),
              child: TextFormField(
                controller: commentController,
                validator: (val) {
                  if (val.length == 0)
                    return "Leave a comment";
                  else
                    return null;
                },
                cursorColor: Colors.black38,
                maxLines: 3,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Leave a comment',
                  hintStyle: TextStyle(fontSize: w * 0.04,color: Color.fromRGBO(217, 217, 217, 1)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Color.fromRGBO(217, 217, 217, 1)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Color.fromRGBO(217, 217, 217, 1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Color.fromRGBO(217, 217, 217, 1)),
                  ),
                ),
              ),
            ),
            Container(
              height: h * 0.055,
              margin: EdgeInsets.only(left: w * 0.6,right:w*0.05,top: h*0.02,bottom: h*0.03),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(84, 201, 165, 1),
                      Color.fromRGBO(156, 175, 23, 1)
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: InkWell(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    Map body = {
                      "course_id": course_id.toString(),
                      "comment": commentController.text
                    };
                    print(body);
                    streamCheck = true;
                    _commentsBloc.CommentsBlocFunction(body, token);
                  }
                },
                child: StreamBuilder<ApiResponse<CommentsModel>>(
                    stream: _commentsBloc.commentsStream,
                    builder: (context, snapshot) {
                      if (streamCheck) {
                        if (snapshot.hasData) {
                          switch (snapshot.data.status) {

                            case Status.LOADING:
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Color.fromRGBO(84, 201, 165, 1),
                                    ),
                                  ),
                                ),
                              );
                              break;

                            case Status.COMPLETED:
                              streamCheck = false;
                              if (snapshot.data.data.success == "comment inserted") {
                                commentController.clear();
                                Future.delayed(Duration.zero, () {
                                  Map body = {
                                    "course_id":course_id.toString()
                                  };
                                  _discussionForumFuture = _discussionForumRepository.DiscussionForumRepositoryFunction(body, token);
                                  setState(() {});
                                });
                                // Fluttertoast.showToast(
                                //     msg: "comment inserted",
                                //     toastLength: Toast.LENGTH_LONG,
                                //     gravity: ToastGravity.BOTTOM,
                                //     timeInSecForIosWeb: 20,
                                //     backgroundColor: Color.fromRGBO(114, 111, 111, 0.9),
                                //     textColor: Colors.white,
                                //     fontSize: 16.0);
                              }
                              print("api call done");
                              break;

                            case Status.ERROR:
                              streamCheck = false;
                              Fluttertoast.showToast(
                                  msg: "Something went wrong please try again!",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 20,
                                  backgroundColor: Color.fromRGBO(114, 111, 111, 0.9),
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              print("api call not done");
                              break;
                          }
                        }
                      }
                      return Center(
                        child: Text(
                          'Comment',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: w*0.045),
                        ),
                      );
                    }),
              ),
            ),
            Divider(
              thickness: 1,
              height: h*0.025,
            ),
            FutureBuilder<DiscusssionForumModel>(
                future: _discussionForumFuture,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    if(snapshot.data.data!=null){
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: snapshot.data.data.comments.length,
                          itemBuilder: (context,index){
                           visibilityViewReply.add(List.generate(snapshot.data.data.comments.length, (index) => false));
                           visibilityReply.add(List.generate(snapshot.data.data.comments.length, (index) => false));
                          return Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: h * 0.0,left: w*0.04),
                                    child: CircleAvatar(
                                      radius: w * 0.09,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: w * 0.08,
                                        backgroundImage: NetworkImage("$imageURL${snapshot.data.data.comments[index].profilePic}"),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: w*0.02,top: h*0.013),
                                              child: Text(snapshot.data.data.comments[index].fullname,
                                                style: TextStyle(fontSize: w*0.035,color: Color.fromRGBO(108, 108, 108, 1)),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(right: w*0.05),
                                              child: Text(
                                                snapshot.data.data.comments[index].timePassed,
                                                style: TextStyle(color: Color.fromRGBO(108, 108, 108, 1)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: w*0.02,top: h*0.005),
                                          child: Text(snapshot.data.data.comments[index].comment,
                                            style: TextStyle(fontSize: w*0.035,color: Color.fromRGBO(108, 108, 108, 1),fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: (){
                                                visibilityViewReply[index] = true;
                                                setState(() {});
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(left: w*0.018,top: h*0.01),
                                                child: visibilityViewReply[index] != true?Text('View Replies',
                                                  style: TextStyle(fontSize: w*0.035,color: Color.fromRGBO(84, 201, 165, 1),fontWeight: FontWeight.w500),
                                                ):
                                                InkWell(
                                                  onTap: (){
                                                    visibilityViewReply[index] = false;
                                                    setState(() {});
                                                  },
                                                  child: Text('Hide Replies',
                                                    style: TextStyle(fontSize: w*0.035,color: Color.fromRGBO(84, 201, 165, 1),fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: (){
                                                visibilityReply[index] = true;
                                                setState(() {});
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(left: w*0.03,top: h*0.01),
                                                child: Text('Reply',
                                                  style: TextStyle(fontSize: w*0.035,color: Color.fromRGBO(108, 108, 108, 1),fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Visibility(
                                            visible: visibilityViewReply[index]==true?true:false,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(top: h*0.01),
                                                  child: ListView.builder(
                                                      scrollDirection: Axis.vertical,
                                                      shrinkWrap: true,
                                                      physics: ScrollPhysics(),
                                                      itemCount: snapshot.data.data.comments[index].replies.length,
                                                      itemBuilder: (context,index1){
                                                        return Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(top: h*0.015),
                                                              child: CircleAvatar(
                                                                radius: w * 0.06,
                                                                backgroundColor: Colors.white,
                                                                child: CircleAvatar(
                                                                  radius: w * 0.05,
                                                                  backgroundImage: NetworkImage("$imageURL${snapshot.data.data.comments[index].replies[index1].profilePic}"),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsets.only(left: w*0.018,top: h*0.023),
                                                                        child: Text(snapshot.data.data.comments[index].replies[index1].fullname,
                                                                          style: TextStyle(fontSize: w*0.032,color: Color.fromRGBO(108, 108, 108, 1)),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(left: w*0.21,right: w*0.03,top: h*0.023),
                                                                        child: Text(snapshot.data.data.comments[index].replies[index1].timePassed,
                                                                          style: TextStyle(fontSize: w*0.03,color: Color.fromRGBO(108, 108, 108, 1)),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: w*0.018,top: h*0.004),
                                                                    child: Text(snapshot.data.data.comments[index].replies[index1].comment,
                                                                      style: TextStyle(fontSize: w*0.032,fontWeight: FontWeight.w500,color: Color.fromRGBO(108, 108, 108, 1)),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      }
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                        Visibility(
                                          visible: visibilityReply[index]==true?true:false,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              StreamBuilder<ApiResponse<ReplyModel>>(
                                                  stream: _replyBloc.replyStream,
                                                  builder: (context, snapshot) {
                                                    if (streamCheck) {
                                                      if (snapshot.hasData) {
                                                        switch (snapshot.data.status) {

                                                          case Status.LOADING:
                                                            return Container();
                                                            break;

                                                          case Status.COMPLETED:
                                                            streamCheck = false;
                                                            if (snapshot.data.data.success == "comment inserted") {
                                                              replyController.clear();
                                                              Future.delayed(Duration.zero, () {
                                                                Map body = {
                                                                  "course_id":course_id.toString()
                                                                };
                                                                _discussionForumFuture = _discussionForumRepository.DiscussionForumRepositoryFunction(body, token);
                                                                setState(() {});
                                                              });
                                                              // Fluttertoast.showToast(
                                                              //     msg: "comment inserted",
                                                              //     toastLength: Toast.LENGTH_LONG,
                                                              //     gravity: ToastGravity.BOTTOM,
                                                              //     timeInSecForIosWeb: 20,
                                                              //     backgroundColor: Color.fromRGBO(114, 111, 111, 0.9),
                                                              //     textColor: Colors.white,
                                                              //     fontSize: 16.0);
                                                            }
                                                            print("api call done");
                                                            break;

                                                          case Status.ERROR:
                                                            streamCheck = false;
                                                            Fluttertoast.showToast(
                                                                msg: "Something went wrong please try again!",
                                                                toastLength: Toast.LENGTH_LONG,
                                                                gravity: ToastGravity.BOTTOM,
                                                                timeInSecForIosWeb: 20,
                                                                backgroundColor: Color.fromRGBO(114, 111, 111, 0.9),
                                                                textColor: Colors.white,
                                                                fontSize: 16.0);
                                                            print("api call not done");
                                                            break;
                                                        }
                                                      }
                                                    }
                                                    return Container();
                                                  }),
                                              Container(
                                                margin: EdgeInsets.only(right: w*0.04,top: h*0.01),
                                                height: h*0.058,
                                                child: TextField(
                                                  style: TextStyle(fontSize: w*0.03),
                                                  controller: replyController,
                                                  cursorColor: Colors.black38,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    suffixIcon: IconButton(
                                                      icon: Icon(Icons.send_rounded,size: w*0.04,color: Colors.black54,),
                                                      onPressed: (){
                                                        Map body = {
                                                          "course_id":snapshot.data.data.comments[index].courseId,
                                                          "parent_id":snapshot.data.data.comments[index].id.toString(),
                                                          "comment": replyController.text
                                                        };
                                                        print(body);
                                                        streamCheck = true;
                                                        _replyBloc.ReplyBlocFunction(body, token);
                                                      },
                                                    ),
                                                    hintText: 'Add a Reply',
                                                    hintStyle: TextStyle(fontSize: w * 0.035),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                                      borderSide: BorderSide(width: 1,color: Color.fromRGBO(217, 217, 217, 1)),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                                      borderSide: BorderSide(width: 1,color: Color.fromRGBO(217, 217, 217, 1)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  visibilityReply[index] = false;
                                                  setState(() {
                                                  });
                                                },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(top: h*0.01,right: w*0.04),
                                                    child: Align(
                                                      alignment: Alignment.topRight,
                                                        child: Text(
                                                          'Cancel',
                                                          style: TextStyle(fontSize: w*0.035,fontWeight: FontWeight.w500,color: Color.fromRGBO(84, 201, 165, 1)),

                                                        )
                                                    ),
                                                  )
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                height: h*0.025,
                              ),
                            ],
                          );
                          });

                    }else{
                      return Center(child: Text("No data"));
                    }
                  }else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(child: Text("error"));
                  } else {
                    return Center(child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(156, 175, 23, 1),
                      ),
                    ));
                  }
                }
            ),
          ],
        ),
      ),
    );
  }
}
