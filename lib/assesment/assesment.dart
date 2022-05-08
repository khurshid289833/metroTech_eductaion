import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/assesment/assesmentInfo.dart';
import 'package:metrotech_education/assesment/bloc/assessmentBloc.dart';
import 'package:metrotech_education/assesment/model/assessmentModel.dart';
import 'package:metrotech_education/viewcourse/model/viewcourseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Assesment extends StatefulWidget {
  String course_id;
  List assesment;

  Assesment(this.course_id, this.assesment);

  @override
  _AssesmentState createState() => _AssesmentState(course_id, assesment);
}

class _AssesmentState extends State<Assesment> {
  String course_id;
  List<Assessment> assesment;

  _AssesmentState(this.course_id, this.assesment);

  String _radioValue;
  bool streamCheck = false;
  AssessmentBloc _assessmentBloc;
  SharedPreferences prefs;
  String token = "";
  List<String> radioState = [];

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString("access_token");
  }

  @override
  void initState() {
    createSharedPref();
    _assessmentBloc = AssessmentBloc();
    super.initState();
  }
  int checkPoint = 0;

  @override
  Widget build(BuildContext context) {
    int start = 0;
    int end = assesment.length-1;
    List<String> options = assesment[checkPoint].options.split(',');
    List<String> optionSample = assesment[checkPoint].optionSample.split(',');
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
                Navigator.pop(context,true);
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
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.03),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Color.fromRGBO(242, 243, 245, 1),
                      border: Border.all(color: Color.fromRGBO(108, 108, 108, 0.5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: h * 0.02, left: w * 0.04),
                        child: Text(assesment[checkPoint].assessmentName,
                          style: TextStyle(fontSize: w*0.04,fontWeight: FontWeight.w500,),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: h * 0.015, left: w * 0.04, bottom: h * 0.02,right: w*0.03),
                        child: Text(
                            'You need to pass this assessment to unlock next chapter',
                          style: TextStyle(fontSize: w*0.035,fontWeight: FontWeight.w500,color: Color.fromRGBO(108, 108, 108, 1)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.05, top: h * 0.05),
                  child: Text(
                      '${checkPoint + 1}. ${assesment[checkPoint].questions}',
                    style: TextStyle(fontSize: w*0.045,fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: h*0.02,left: w*0.05),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: options.length,
                      itemBuilder: (context, index1) {
                        _radioValue=assesment[checkPoint].selectedAnswer;
                        return Row(
                          children: [
                            Radio(
                                value: '${options[index1]}',
                                groupValue: _radioValue,
                                activeColor: Color.fromRGBO(77, 200, 174, 1),
                                onChanged: (val) {
                                  _radioValue = val;
                                  assesment[checkPoint].selectedAnswer=_radioValue;
                                  setState(() {});
                                }),
                            Text(
                              '${options[index1]}.   ${optionSample[index1]}',
                              style: new TextStyle(fontSize: w*0.04, color: Color.fromRGBO(108, 108, 108, 1)
                              ),
                            ),
                          ],
                        );
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    checkPoint!=0?
                    Container(
                      margin: EdgeInsets.only(left: w * 0.05,top: h*0.03),
                      child: InkWell(
                        onTap: (){
                          checkPoint > start ? checkPoint = checkPoint - 1 : checkPoint = checkPoint;
                          setState(() {});
                        },
                        child: Text('<<  Previous',
                          style: TextStyle(fontSize: w*0.04,fontWeight: FontWeight.bold,color: Color.fromRGBO(108, 108, 108, 1),),
                        ),
                      ),
                    ):Container(),
                    InkWell(
                      onTap: () {
                        Map body = {
                          "course_id": course_id,
                          "assessment_id": assesment[checkPoint].assessmentId.toString(),
                          "question_id": assesment[checkPoint].questionsId.toString(),
                          "answer": _radioValue
                        };
                        print(body);
                        streamCheck = true;
                        _assessmentBloc.AssessmentBlocFunction(body, token);
                        showDialog(
                          useRootNavigator: false,
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => Center(
                            child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor:
                                AlwaysStoppedAnimation<Color>(
                                  Color.fromRGBO(84, 201, 165, 1),
                                )),
                          ),
                        );
                      },
                      child: StreamBuilder<ApiResponse<AssessmentModel>>(
                          stream: _assessmentBloc.assessmentStream,
                          builder: (context, snapshot) {
                            if (streamCheck) {
                              if (snapshot.hasData) {
                                switch (snapshot.data.status) {
                                  case Status.LOADING:
                                    return Container(
                                      height: 2,
                                      width: 2,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                          valueColor: AlwaysStoppedAnimation<
                                              Color>(Color.fromRGBO(77, 200, 174, 1)),
                                        ),
                                      ),
                                    );
                                    break;

                                  case Status.COMPLETED:
                                    streamCheck = false;
                                    Navigator.pop(context);
                                    Future.delayed(Duration.zero, () {
                                      setState(() {
                                        checkPoint < end ? checkPoint = checkPoint + 1 : checkPoint = checkPoint;
                                        _radioValue = null;
                                      });
                                    });

                                    if (snapshot.data.data.message == "Answered") {
                                      Fluttertoast.showToast(
                                          msg: snapshot.data.data.message,
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 20,
                                          backgroundColor: Color.fromRGBO(114, 111, 111, 0.9),
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      print("api call done");
                                    }

                                    if (snapshot.data.data.message == "Answer updated") {
                                      Fluttertoast.showToast(
                                          msg: snapshot.data.data.message,
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 20,
                                          backgroundColor: Color.fromRGBO(114, 111, 111, 0.9),
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      print("api call done");
                                    }

                                    if(checkPoint==end){
                                      Future.delayed(Duration.zero, () async {
                                         Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => AssessmentInfo()),);
                                      });
                                    }

                                    break;

                                  case Status.ERROR:
                                    Navigator.pop(context);
                                    streamCheck = false;
                                    if(_radioValue == null){
                                      Fluttertoast.showToast(
                                          msg: "Please select a option",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 20,
                                          backgroundColor: Color.fromRGBO(114, 111, 111, 0.9),
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }else{
                                      Fluttertoast.showToast(
                                          msg: "Something went wrong",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 20,
                                          backgroundColor: Color.fromRGBO(114, 111, 111, 0.9),
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                    print("api call not done");
                                    break;
                                }
                              }
                            }
                            return Padding(
                              padding: EdgeInsets.only(right: w*0.05,top: h*0.03),
                              child: Text(
                                'Save & Submit  >>',
                                style: TextStyle(fontSize: w*0.04,fontWeight: FontWeight.bold,color: Color.fromRGBO(84, 201, 165, 1),),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ],
        )

      ),
    );
  }
}
