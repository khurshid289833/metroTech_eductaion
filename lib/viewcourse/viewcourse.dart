import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/assesment/assesment.dart';
import 'package:metrotech_education/certificates/certificate.dart';
import 'package:metrotech_education/courseRating/courseRating.dart';
import 'package:metrotech_education/courseRating/courseRatingInfo.dart';
import 'package:metrotech_education/discussionForum/discussionForum.dart';
import 'package:metrotech_education/instructorDetails/instructorDetails.dart';
import 'package:metrotech_education/viewcourse/bloc/courseCompletionBloc.dart';
import 'package:metrotech_education/viewcourse/model/courseCompletionModel.dart';
import 'package:metrotech_education/viewcourse/model/viewcourseModel.dart';
import 'package:metrotech_education/viewcourse/repository/viewcourseRepository.dart';
import 'package:metrotech_education/viewcourse/viewCourseContent.dart';
import 'package:metrotech_education/viewcourse/viewCourseDetails.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class ViewCourse extends StatefulWidget {
  String courseid;

  ViewCourse(this.courseid);

  @override
  _ViewCourseState createState() => _ViewCourseState(courseid);
}

class _ViewCourseState extends State<ViewCourse> {
  String courseid;

  _ViewCourseState(this.courseid);

  SharedPreferences prefs;
  String token = "";
  CourseCompletionBloc _courseCompletionBloc = CourseCompletionBloc();
  Future<ViewCourseModel> _viewCoursefuture;
  ViewCourseRepository _viewCourseRepository;
  bool streamCheck = false;
  List checkBoxValue = [];

  double localTotalCompletePercentage;
  double localChapterCompletePercentage;


  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString("access_token");
    _viewCourseRepository = ViewCourseRepository();
    _viewCoursefuture = _viewCourseRepository.viewCourse(courseid, token);
    setState(() {});
  }

  @override
  void initState() {
    createSharedPref();
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
              icon: Icon(Icons.arrow_back_rounded, color: Colors.black, size: 25),
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
      body: Container(
        color: Color.fromRGBO(249, 249, 249, 1),
        child: Column(
          children: [
            StreamBuilder<ApiResponse<CourseCompletionModel>>(
                stream: _courseCompletionBloc.courseCompletionStream,
                builder: (context, snapshot) {
                  if (streamCheck) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          return Container();
                          break;

                        case Status.COMPLETED:
                          streamCheck = false;
                          if (snapshot.data.data.success == "Marked") {
                            Future.delayed(Duration.zero, () {
                              _viewCoursefuture = _viewCourseRepository.viewCourse(courseid, token);
                              setState(() {});
                            });
                            Future.delayed(Duration(seconds: 1), () async {
                              Navigator.pop(context);
                              AwesomeDialog(
                                  context: context,
                                  dismissOnTouchOutside: false,
                                  useRootNavigator: true,
                                  dialogType: DialogType.SUCCES,
                                  animType: AnimType.SCALE,
                                  title: 'Success!',
                                  desc: 'Chapter marked successfully',
                                  btnOkOnPress: () {
                                    //Navigator.pop(context);
                                  }).show();
                            });
                          }
                          if (snapshot.data.data.success == "Unmarked") {
                            Future.delayed(Duration.zero, () {
                              _viewCoursefuture = _viewCourseRepository.viewCourse(courseid, token);
                              setState(() {});
                            });
                            Future.delayed(Duration(seconds: 1), () async {
                              Navigator.pop(context);
                              AwesomeDialog(
                                  context: context,
                                  dismissOnTouchOutside: false,
                                  useRootNavigator: true,
                                  dialogType: DialogType.SUCCES,
                                  animType: AnimType.SCALE,
                                  title: 'Success!',
                                  desc: 'Chapter unmarked successfully',
                                  btnOkOnPress: () {}).show();
                            });
                          }
                          print("api call done");
                          break;

                        case Status.ERROR:
                          streamCheck = false;
                          Navigator.pop(context);
                          AwesomeDialog(
                              context: context,
                              dismissOnTouchOutside: false,
                              useRootNavigator: true,
                              dialogType: DialogType.ERROR,
                              animType: AnimType.SCALE,
                              title: 'Error!',
                              desc: 'Something went wrong please try again',
                              btnOkColor: Colors.red,
                              btnOkOnPress: () {}).show();
                          print("api call not done");
                          break;
                      }
                    }
                  }
                  return Container();
                }),
            Expanded(
              child: FutureBuilder<ViewCourseModel>(
                  future: _viewCoursefuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.data != null) {
                        checkBoxValue.clear();
                        int courseLength = snapshot.data.data.courseContent.length;
                        localTotalCompletePercentage = double.parse(snapshot.data.data.totalCourseCompletionPercentage);
                        // snapshot.data.data.courseContentCompleted!=snapshot.data.data.totalCourseContent?
                        // snapshot.data.data.courseContentCompleted+1:
                        // snapshot.data.data.courseContentCompleted;
                        return ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          children: [
                            Card(
                              margin: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.03, bottom: h * 0.03),
                              elevation: 0.7,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: w * 0.03, top: h * 0.025),
                                          child: Text(
                                            snapshot.data.data.courseName,
                                            style: TextStyle(fontSize: w * 0.045, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: w * 0.03, top: h * 0.005),
                                        child: Icon(
                                          Icons.people_outline,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: w * 0.01, top: h * 0.005),
                                        child: Text(
                                          snapshot.data.data.instructor,
                                          style: TextStyle(color: Colors.black54, fontSize: w * 0.038),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: w * 0.03, top: h * 0.01),
                                        child: RatingBarIndicator(
                                          rating: snapshot.data.data.rating!=null?double.parse(snapshot.data.data.rating):0.0,
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Color.fromRGBO(249, 160, 27, 1),
                                          ),
                                          itemCount: 5,
                                          itemSize: 16.0,
                                          direction: Axis.horizontal,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: w * 0.03, top: h * 0.01),
                                        child: Text(' ${snapshot.data.data.rating!=null?snapshot.data.data.rating:0.0} (202,123)',
                                            style: TextStyle(fontSize: w * 0.03, color: Colors.black54)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: h * 0.1,
                                        width: w * 0.41,
                                        margin: EdgeInsets.only(left: w * 0.02, top: h * 0.025, bottom: h * 0.015),
                                        child: Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(top: h * 0.025, bottom: h * 0.005),
                                                child: Text(
                                                  'Total Chapter Completed',
                                                  style: TextStyle(fontSize: w * 0.027, fontWeight: FontWeight.w700, color: Color.fromRGBO(113, 117, 116, 1)),
                                                ),
                                              ),
                                              Text(
                                                "${snapshot.data.data.courseContentCompleted}/${snapshot.data.data.totalCourseContent}",
                                                style: TextStyle(fontSize: w * 0.035, fontWeight: FontWeight.w700, color: Color.fromRGBO(113, 117, 116, 1)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: h * 0.1,
                                        width: w * 0.41,
                                        margin: EdgeInsets.only(right: w * 0.02, top: h * 0.025, bottom: h * 0.015),
                                        child: Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(top: h * 0.025, bottom: h * 0.005),
                                                child: Text(
                                                  'Total percentage Completed',
                                                  style: TextStyle(fontSize: w * 0.027, fontWeight: FontWeight.w700, color: Color.fromRGBO(113, 117, 116, 1)),
                                                ),
                                              ),
                                              Text(
                                                "${localTotalCompletePercentage.toInt()}%",
                                                style: TextStyle(fontSize: w * 0.035, fontWeight: FontWeight.w700, color: Color.fromRGBO(113, 117, 116, 1)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              margin: EdgeInsets.only(left: w * 0.05, right: w * 0.05, bottom: h * 0.03),
                              elevation: 0.7,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: snapshot.data.data.courseContent.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    checkBoxValue.add(List.generate(snapshot.data.data.courseContent[index].courseContentDetails.length,
                                        (item) => !(snapshot.data.data.courseContent[index].courseContentDetails[item].markedAs == null)));
                                    localChapterCompletePercentage = double.parse(snapshot.data.data.courseContent[index].completePercentage);
                                    //snapshot.data.data.courseContent[index].courseContentDetails[item].markedAs == "completed" && snapshot.data.data.courseContent[index].courseContentDetails[item].markedAs != null? true : false))
                                    return Column(
                                      children: [
                                        ExpansionTile(
                                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                          trailing: Icon(
                                            Icons.keyboard_arrow_down_sharp,
                                            color: Color.fromRGBO(84, 201, 165, 1),
                                            size: w * 0.07,
                                          ),
                                          title: Padding(
                                            padding: EdgeInsets.only(top: h * 0.01),
                                            child: Text(
                                              snapshot.data.data.courseContent[index].courseContentName,
                                              style: TextStyle(fontSize: w * 0.04, fontWeight: FontWeight.bold, color: Colors.black,),
                                            ),
                                          ),
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                snapshot.data.data.courseContent[index].totalCourseContentDetails!=0?
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      height: h * 0.038,
                                                      width: w * 0.15,
                                                      alignment: Alignment.center,
                                                      margin: EdgeInsets.only(left: w * 0.05, top: h * 0.02),
                                                      decoration: BoxDecoration(
                                                        color: Color.fromRGBO(84, 201, 165, 1),
                                                        borderRadius: BorderRadius.circular(3),
                                                      ),
                                                      child: Text(
                                                        "${snapshot.data.data.courseContent[index].courseContentDetailsCompleted}/${snapshot.data.data.courseContent[index].totalCourseContentDetails}",
                                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(top: h * 0.025, right: w * 0.03),
                                                          child: LinearPercentIndicator(
                                                            width: w * 0.5,
                                                            lineHeight: 4.5,
                                                            percent: double.parse(snapshot.data.data.courseContent[index].completePercentage) / (100.0),
                                                            backgroundColor: Color.fromRGBO(209, 204, 204, 1),
                                                            progressColor: Color.fromRGBO(84, 201, 165, 1),
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets.only(top: h * 0.006, right: w * 0.05),
                                                            child: Text(
                                                              "${localChapterCompletePercentage.toInt()}% Complete",
                                                              style: TextStyle(fontWeight: FontWeight.w600),
                                                            )),
                                                      ],
                                                    ),
                                                  ],
                                                ):Container(),
                                                Divider(
                                                  color: Color.fromRGBO(209, 204, 204, 1),
                                                  thickness: 1,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: w * 0.05, top: h * 0.01),
                                                  child: Text(
                                                    snapshot.data.data.courseContent[index].courseContentName,
                                                    style: TextStyle(fontSize: w * 0.035, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: w * 0.025),
                                                  child: Html(
                                                      data: snapshot.data.data.courseContent[index].courseContentDesc,
                                                      style: {
                                                        "h1": Style(fontSize: FontSize.medium, lineHeight: LineHeight(1.2), color: Color.fromRGBO(113, 117, 116, 1)),
                                                        "h2": Style(fontSize: FontSize.medium),
                                                        "h3": Style(fontSize: FontSize.medium),
                                                        "h4": Style(fontSize: FontSize.medium),
                                                        "h5": Style(fontSize: FontSize.medium),
                                                        "h6": Style(fontSize: FontSize.medium),
                                                      }),
                                                ),
                                                ListView.builder(
                                                    scrollDirection: Axis.vertical,
                                                    shrinkWrap: true,
                                                    physics: ScrollPhysics(),
                                                    itemCount: snapshot.data.data.courseContent[index].courseContentDetails.length,
                                                    itemBuilder: (BuildContext context, int index1) {
                                                      return index == 0
                                                          ? Row(
                                                              children: [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Padding(padding: EdgeInsets.only(left: w * 0.015),
                                                                    child: Checkbox(
                                                                      activeColor: Color.fromRGBO(84, 201, 165, 1),
                                                                      value: checkBoxValue[index][index1],
                                                                      onChanged: (value) {
                                                                        setState(
                                                                            () {
                                                                          this.checkBoxValue[index][index1] = value;
                                                                        });
                                                                        Map body = {
                                                                          "course_id": courseid.toString(),
                                                                          "course_content_id": snapshot.data.data.courseContent[index].id.toString(),
                                                                          "course_content_details_id": snapshot.data.data.courseContent[index].courseContentDetails[index1].id.toString()
                                                                        };
                                                                        print(body);
                                                                        streamCheck = true;
                                                                        _courseCompletionBloc.courseCompletionBlocFunction(body, token);
                                                                        showDialog(
                                                                          useRootNavigator: false,
                                                                          barrierDismissible: false,
                                                                          context: context,
                                                                          builder: (context) =>
                                                                                  Center(
                                                                                     child: CircularProgressIndicator(
                                                                                         strokeWidth: 2.0,
                                                                                          valueColor: AlwaysStoppedAnimation<Color>(
                                                                                              Color.fromRGBO(84, 201, 165, 1),
                                                                                )),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 5,
                                                                  child: InkWell(
                                                                    onTap: () {
                                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCourseContent(
                                                                                    snapshot.data.data.courseContent[index].courseContentDetails[index1].courseContentDetailsName,
                                                                                    snapshot.data.data.courseContent[index].courseContentDetails[index1].courseContentDetailsDesc,
                                                                                    snapshot.data.data.courseContent[index].courseContentDetails[index1].courseContentDetailsContent,
                                                                                  )));
                                                                    },
                                                                    child: Text(
                                                                      snapshot.data.data.courseContent[index].courseContentDetails[index1].courseContentDetailsName,
                                                                      style: TextStyle(fontSize: w * 0.048),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : snapshot.data.data.courseContent[index - 1].markedAs == "completed"
                                                            && snapshot.data.data.courseContent[index - 1].assessment == null
                                                              ? Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets.only(left: w * 0.015),
                                                                      child: Checkbox(
                                                                        activeColor: Color.fromRGBO(84, 201, 165, 1),
                                                                        value: checkBoxValue[index][index1],
                                                                        onChanged: (value) {
                                                                          setState(
                                                                              () {
                                                                            this.checkBoxValue[index][index1] = value;
                                                                          });
                                                                          Map body = {
                                                                            "course_id": courseid.toString(),
                                                                            "course_content_id": snapshot.data.data.courseContent[index].id.toString(),
                                                                            "course_content_details_id": snapshot.data.data.courseContent[index].courseContentDetails[index1].id.toString()
                                                                          };
                                                                          print(body);
                                                                          streamCheck = true;
                                                                          _courseCompletionBloc.courseCompletionBlocFunction(body, token);
                                                                          showDialog(
                                                                            useRootNavigator: false,
                                                                            barrierDismissible: false,
                                                                            context: context,
                                                                            builder: (context) =>
                                                                                Center(
                                                                                  child: CircularProgressIndicator(
                                                                                  strokeWidth: 2.0,
                                                                                  valueColor: AlwaysStoppedAnimation<Color>(
                                                                                    Color.fromRGBO(84, 201, 165, 1),
                                                                                  )),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.push(context, MaterialPageRoute(
                                                                                builder: (context) => ViewCourseContent(
                                                                                      snapshot.data.data.courseContent[index].courseContentDetails[index1].courseContentDetailsName,
                                                                                      snapshot.data.data.courseContent[index].courseContentDetails[index1].courseContentDetailsDesc,
                                                                                      snapshot.data.data.courseContent[index].courseContentDetails[index1].courseContentDetailsContent,
                                                                                    )));
                                                                      },
                                                                      child: Text(
                                                                        snapshot.data.data.courseContent[index].courseContentDetails[index1].courseContentDetailsName,
                                                                        style: TextStyle(fontSize: w * 0.048),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Row(
                                                                  children: [
                                                                    Padding(padding: EdgeInsets.only(left: w * 0.015),
                                                                      child: Checkbox(
                                                                        activeColor: Color.fromRGBO(84, 201, 165, 1),
                                                                        value: checkBoxValue[index][index1],
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCourseContent(
                                                                                      snapshot.data.data.courseContent[index].courseContentDetails[index1].courseContentDetailsName,
                                                                                      snapshot.data.data.courseContent[index].courseContentDetails[index1].courseContentDetailsDesc,
                                                                                      snapshot.data.data.courseContent[index].courseContentDetails[index1].courseContentDetailsContent,
                                                                                    )));
                                                                      },
                                                                      child: Text(
                                                                        snapshot.data.data.courseContent[index].courseContentDetails[index1].courseContentDetailsName,
                                                                        style: TextStyle(fontSize: w * 0.048),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                );
                                                    }),
                                                snapshot.data.data.courseContent[index].assessment!=null
                                                    && snapshot.data.data.courseContent[index].courseContentDetailsCompleted == snapshot.data.data.courseContent[index].totalCourseContentDetails
                                                    ? Center(
                                                        child: Container(
                                                          height: h * 0.05,
                                                          width: w * 0.42,
                                                          margin: EdgeInsets.only(top: h * 0.02, bottom: h * 0.04),
                                                          decoration: BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: [
                                                                      Color.fromRGBO(84, 201, 165, 1),
                                                                      Color.fromRGBO(156, 175, 23, 1)
                                                                    ],
                                                                  ),
                                                                  borderRadius: BorderRadius.all(
                                                                          Radius.circular(80.0))),
                                                          child: Center(
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.push(context, MaterialPageRoute(builder: (context) => Assesment(
                                                                            snapshot.data.data.courseId.toString(),
                                                                            snapshot.data.data.courseContent[index].assessment))).then((value) {initState();});
                                                              },
                                                              child: Text(
                                                                'Assessment 1',
                                                                //snapshot.data.data.courseContent[index].assessment[index].assessmentName,
                                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: w * 0.045),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Container()
                                              ],
                                            ),
                                          ],
                                        ),
                                        (courseLength > index + 1)
                                            ? Divider(
                                                thickness: 1,
                                              )
                                            : Container(),
                                      ],
                                    );
                                  }),
                            ),
                            Card(
                              margin: EdgeInsets.only(left: w * 0.05, right: w * 0.05, bottom: h * 0.03),
                              elevation: 0.7,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCourseDetails(snapshot.data.data.courseDesc)),);
                                    },
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: w * 0.05, bottom: h * 0.015, top: h * 0.04),
                                          child: Image.asset(
                                            'images/icon_course.png',
                                            height: h * 0.025,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: w * 0.035, bottom: h * 0.015, top: h * 0.04),
                                          child: Text(
                                            'Course Details',
                                            style: TextStyle(fontSize: w * 0.04, color: Color.fromRGBO(108, 108, 108, 1), fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(right: w * 0.05, bottom: h * 0.015, top: h * 0.04),
                                          child: Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            color: Color.fromRGBO(113, 117, 116, 1),
                                            size: w * 0.04,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Color.fromRGBO(209, 204, 204, 0.5),
                                    thickness: 1,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => InstructorDetails(snapshot.data.data.instructorId)),);
                                    },
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: w * 0.05, bottom: h * 0.015, top: h * 0.015),
                                          child: Image.asset(
                                            'images/icon_instructor.png',
                                            height: h * 0.025,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: w * 0.035, bottom: h * 0.015, top: h * 0.015),
                                          child: Text(
                                            'Instructor Details',
                                            style: TextStyle(fontSize: w * 0.04, color: Color.fromRGBO(108, 108, 108, 1), fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(right: w * 0.05, bottom: h * 0.015, top: h * 0.015),
                                          child: Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            color: Color.fromRGBO(108, 108, 108, 1),
                                            size: w * 0.04,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Color.fromRGBO(209, 204, 204, 0.5),
                                    thickness: 1,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => DiscussionForum(snapshot.data.data.courseId)),);
                                    },
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: w * 0.05, bottom: h * 0.015, top: h * 0.015),
                                          child: Image.asset(
                                            'images/icon_q&a.png',
                                            height: h * 0.025,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: w * 0.035, bottom: h * 0.015, top: h * 0.015),
                                          child: Text(
                                            'Q&A',
                                            style: TextStyle(fontSize: w * 0.04, color: Color.fromRGBO(108, 108, 108, 1), fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(right: w * 0.05, bottom: h * 0.015, top: h * 0.015),
                                          child: Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            color: Color.fromRGBO(108, 108, 108, 1),
                                            size: w * 0.04,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Color.fromRGBO(209, 204, 204, 0.5),
                                    thickness: 1,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      snapshot.data.data.rating == null
                                          ? Navigator.push(context, MaterialPageRoute(builder: (context) => CourseRating(snapshot.data.data.courseId)),)
                                          : Navigator.push(context, MaterialPageRoute(builder: (context) => CourseRatingInfo()),);
                                    },
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: w * 0.05, bottom: h * 0.015, top: h * 0.015),
                                          child: Image.asset(
                                            'images/icon_rating.png',
                                            height: h * 0.025,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: w * 0.035, bottom: h * 0.015, top: h * 0.015),
                                          child: Text(
                                            'Rating',
                                            style: TextStyle(fontSize: w * 0.04, color: Color.fromRGBO(108, 108, 108, 1), fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(right: w * 0.05, bottom: h * 0.015, top: h * 0.015),
                                          child: Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            color: Color.fromRGBO(108, 108, 108, 1),
                                            size: w * 0.04,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Color.fromRGBO(209, 204, 204, 0.5),
                                    thickness: 1,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewExample()),);
                                    },
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: w * 0.05, bottom: h * 0.04, top: h * 0.015),
                                          child: Image.asset(
                                            'images/icon_certificate.png',
                                            height: h * 0.025,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: w * 0.035, bottom: h * 0.04, top: h * 0.015),
                                          child: Text(
                                            'Certificates',
                                            style: TextStyle(fontSize: w * 0.04, color: Color.fromRGBO(108, 108, 108, 1), fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(right: w * 0.05, bottom: h * 0.04, top: h * 0.015),
                                          child: Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            color: Color.fromRGBO(108, 108, 108, 1),
                                            size: w * 0.04,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Center(child: Text("No data"));
                      }
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Center(child: Text("error"));
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3.0,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromRGBO(156, 175, 23, 1),
                          ),
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
