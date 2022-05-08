import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/constants.dart';
import 'package:metrotech_education/instructorDetails/model/instructorDetailsModel.dart';
import 'package:metrotech_education/instructorDetails/repository/instructorDetailsRepository.dart';
import 'package:metrotech_education/instructorRating/bloc/instructorRatingBloc.dart';
import 'package:metrotech_education/instructorRating/model/instructorRatingModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class InstructorDetails extends StatefulWidget {
  int instructor_id;
  InstructorDetails(this.instructor_id);
  @override
  _InstructorDetailsState createState() => _InstructorDetailsState(instructor_id);
}

class _InstructorDetailsState extends State<InstructorDetails> {
  int instructor_id;
  _InstructorDetailsState(this.instructor_id);

  final _formKey = GlobalKey<FormState>();
  TextEditingController instructorRatingController = TextEditingController();
  String rating;
  String token = "";
  bool streamCheck = false;
  SharedPreferences prefs;
  Future<InstructorDetailsModel> _instructorDetailsFuture;
  InstructorDetailsRepository _instructorDetailsRepository;
  InstructorRatingBloc _instructorRatingBloc;

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString("access_token");
  }

  @override
  void initState() {
    createSharedPref();
    _instructorDetailsRepository = InstructorDetailsRepository();
    _instructorDetailsFuture = _instructorDetailsRepository.InstructorDetailsRepositoryFunction(instructor_id);
    _instructorRatingBloc = InstructorRatingBloc();
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
      body:  FutureBuilder<InstructorDetailsModel>(
          future: _instructorDetailsFuture,
          builder: (context, snapshot){
            if(snapshot.hasData){
              if(snapshot.data.data!=null){
                return ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.04, top: h * 0.02,bottom: h*0.005),
                        child: Text(
                          'Instructor Details',
                          style: TextStyle(fontSize: w*0.045, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(top: h*0.02,left: w*0.04,right: w*0.04),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: h * 0.02,left: w*0.02),
                                  child: CircleAvatar(
                                    radius: w * 0.12,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: w * 0.11,
                                      backgroundImage: snapshot.data.data[0].profilePic!=null?
                                      NetworkImage("$imageURL${snapshot.data.data[0].profilePic}")
                                          :AssetImage('images/icon_person.png'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: h*0.04,left: w*0.03),
                                        child: Text(snapshot.data.data[0].fullname.toString(),
                                          style: TextStyle(fontSize: w*0.05,fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: h*0.005,left: w*0.03),
                                        child: Text('Programming instructor',
                                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: w*0.04,color: Color.fromRGBO(108, 108, 108, 1)),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: w*0.02,top: h*0.01),
                                            child: RatingBarIndicator(
                                              rating: double.parse(snapshot.data.data[0].rating),
                                              itemBuilder: (context, index) => Icon(
                                                Icons.star,
                                                color: Color.fromRGBO(249, 160, 27, 1),
                                              ),
                                              itemCount: 5,
                                              itemSize: w*0.045,
                                              direction: Axis.horizontal,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: w*0.01,right: w*0.03,top: h*0.012),
                                            child: Text(snapshot.data.data[0].rating,
                                              style: TextStyle(color: Color.fromRGBO(108, 108, 108, 1)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: h * 0.08,
                                  width: w * 0.35,
                                  margin: EdgeInsets.only(left: w * 0.1,bottom: h * 0.015,top: h*0.03),
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
                                          padding: EdgeInsets.only(top: h * 0.015, bottom: h * 0.003),
                                          child: Text(
                                            'Total Students',
                                            style: TextStyle(fontSize: w * 0.027, fontWeight: FontWeight.w700, color: Color.fromRGBO(113, 117, 116, 1)),
                                          ),
                                        ),
                                        Text(
                                          '322',
                                          style: TextStyle(fontSize: w * 0.038, fontWeight: FontWeight.w700, color: Color.fromRGBO(113, 117, 116, 1)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: h * 0.08,
                                  width: w * 0.35,
                                  margin: EdgeInsets.only(left: w * 0.02,bottom: h * 0.015,top: h*0.03),
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
                                          padding: EdgeInsets.only(top: h * 0.015, bottom: h * 0.003),
                                          child: Text(
                                            'Reviews',
                                            style: TextStyle(fontSize: w * 0.027, fontWeight: FontWeight.w700, color: Color.fromRGBO(113, 117, 116, 1)),
                                          ),
                                        ),
                                        Text(
                                          '${snapshot.data.data[0].review}',
                                          style: TextStyle(fontSize: w * 0.038, fontWeight: FontWeight.w700, color: Color.fromRGBO(113, 117, 116, 1)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: w*0.04,top: h*0.02),
                              child: Text('About Me',
                                style: TextStyle(fontSize: w*0.045,fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: w*0.04,right: w*0.04,top: h*0.03,bottom: h*0.03),
                              child: Text('When speed is important a Python can move time-critical '
                                  'functions to extension modules written in languages such as C, or use When '
                                  'speed is important, a Python programmer can move time-critical functions to extension'
                                  ' modules written in languages such as C, or use When speed is important, a Python programmer'
                                  ' can move time-critical functions to extension modules written in languages such as C, or use',
                                style: TextStyle(fontSize: w*0.043,color: Color.fromRGBO(113, 117, 116, 1)),
                              ),
                            )
                          ],
                        ),
                      ),
                      snapshot.data.data[0].rating==null?
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: h*0.03,left: w*0.05),
                              child: Text('Rate Instructor',
                                style: TextStyle(fontSize: w*0.05,fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: h*0.005,left: w*0.05),
                              child: Text('How would you rate your instructor?',
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
                                rating: 0.0,
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
                              child: Text('Review instructor',
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
                                controller: instructorRatingController,
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
                              margin: EdgeInsets.only(left: w * 0.3, right: w * 0.3, top: h * 0.055,bottom: h*0.05),
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
                                      "instructor_id": instructor_id.toString(),
                                      "rating": rating,
                                      "review": instructorRatingController.text
                                    };
                                    print(body);
                                    streamCheck = true;
                                    _instructorRatingBloc.InstructorRatingBlocFunction(body, token);
                                  }
                                },
                                child: StreamBuilder<ApiResponse<InstructorRatingModel>>(
                                    stream: _instructorRatingBloc.instructorRatingStream,
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
                      ):Center(
                        child: Container(
                          margin: EdgeInsets.only(top: h*0.05,bottom: h*0.05),
                          child: Text('You have already rated this instructor.',
                            style: TextStyle(fontSize: w*0.04,fontWeight: FontWeight.w500,color: Color.fromRGBO(84, 201, 165, 0.7)),
                          ),
                        ),
                      ),


                    ],
                  );
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
              ),);
            }
          }
      ),
    );
  }
}
