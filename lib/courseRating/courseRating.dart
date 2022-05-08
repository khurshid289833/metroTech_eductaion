import 'package:flutter/material.dart';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/courseRating/bloc/courseRatingBloc.dart';
import 'package:metrotech_education/courseRating/model/courseRatingModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class CourseRating extends StatefulWidget {
  final course_id;
  CourseRating(this.course_id);
  @override
  _CourseRatingState createState() => _CourseRatingState(course_id);
}

class _CourseRatingState extends State<CourseRating> {
  final course_id;
  _CourseRatingState(this.course_id);

  final _formKey = GlobalKey<FormState>();
  TextEditingController courseRatingController = TextEditingController();
  CourseRatingBloc _courseRatingBloc;
  SharedPreferences prefs;
  String token = "";
  bool streamCheck = false;
  String rating;

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString("access_token");
  }
  @override
  void initState() {
    createSharedPref();
    _courseRatingBloc = CourseRatingBloc();
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/back_pic.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: h*0.03,left: w*0.05),
                child: Text('Rate Course',
                  style: TextStyle(fontSize: w*0.05,fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: h*0.005,left: w*0.05),
                child: Text('How would you rate our course?',
                  style: TextStyle(fontSize: w*0.035,color: Color.fromRGBO(108, 108, 108, 1),fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: h*0.02,left: w*0.04),
                child: SmoothStarRating(
                    allowHalfRating: true,
                    onRated: (v) {
                      rating=v.toString();
                    },
                    starCount: 5,
                    rating: 4.0,
                    size: 37.0,
                    isReadOnly:false,
                    //filledIconData: Icons.star,
                    //halfFilledIconData: Icons.star,
                    defaultIconData: Icons.star,
                    color: Color.fromRGBO(249, 160, 27, 1),
                    borderColor: Color.fromRGBO(217, 217, 217, 1),
                    spacing:3.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: h*0.05,left: w*0.05),
                child: Text('Review Course',
                  style: TextStyle(fontSize: w*0.05,fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: h*0.007,left: w*0.05),
                child: Text('Your opinion matters to us!',
                  style: TextStyle(fontSize: w*0.035,color: Color.fromRGBO(108, 108, 108, 1),fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.03),
                child: TextFormField(
                  controller: courseRatingController,
                  validator: (val) {
                    if (val.length == 0)
                      return "Please provide a review";
                    else
                      return null;
                  },
                  cursorColor: Colors.black38,
                  maxLines: 3,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Please provide a review...',
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
                height: h * 0.06,
                margin: EdgeInsets.only(left: w * 0.3, right: w * 0.3, top: h * 0.055 ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(84, 201, 165, 1),
                        Color.fromRGBO(156, 175, 23, 1)
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(80.0))),
                child: InkWell(
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      Map body = {
                        "course_id": course_id.toString(),
                        "rating": rating,
                        "review": courseRatingController.text
                      };
                      print(body);
                      streamCheck = true;
                    _courseRatingBloc.CourseRatingBlocFunction(body, token);
                    }
                  },
                  child: StreamBuilder<ApiResponse<CourseRatingModel>>(
                      stream: _courseRatingBloc.courseRatingStream,
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
                                if (snapshot.data.data.success == "Rating saved") {
                                  Future.delayed(Duration.zero, () async {
                                    AwesomeDialog(
                                        context: context,
                                        dismissOnTouchOutside: false,
                                        useRootNavigator: true,
                                        dialogType: DialogType.SUCCES,
                                        animType: AnimType.SCALE,
                                        title: 'Success!',
                                        desc: 'Thank you for giving your valuable review',
                                        btnOkOnPress: () {
                                          Navigator.pop(context);
                                        }).show();
                                  });
                                }
                                print("api call done");
                                break;

                              case Status.ERROR:
                                streamCheck = false;
                                Future.delayed(Duration.zero, () async {
                                  AwesomeDialog(
                                      context: context,
                                      dismissOnTouchOutside: false,
                                      useRootNavigator: true,
                                      dialogType: DialogType.ERROR,
                                      animType: AnimType.SCALE,
                                      title: 'Error!',
                                      desc: 'Something went wrong please try again!',
                                      btnOkColor: Colors.red,
                                      btnOkOnPress: () {}).show();
                                });
                                print("api call not done");
                                break;
                            }
                          }
                        }
                        return Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: w*0.045),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
