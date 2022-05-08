import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:metrotech_education/classes/model/privateClassCourseEnrollmentModel.dart';
import 'package:metrotech_education/classes/repository/privateClassCourseEnrollmentListingRepository.dart';
import 'package:metrotech_education/constants.dart';
import 'package:metrotech_education/payment/paypalPayment.dart';
import 'package:metrotech_education/paymentPrivate/paypalPaymentPrivate.dart';
import 'package:metrotech_education/signin/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrivateClass extends StatefulWidget {

  int privateClassId;
  String privateClassName;
  String privateClassDesc;
  String privateClassPrice;

  PrivateClass(this.privateClassId,this.privateClassName,this.privateClassDesc,this.privateClassPrice);

  @override
  _PrivateClassState createState() => _PrivateClassState(privateClassId,privateClassName,privateClassDesc,privateClassPrice);
}

class _PrivateClassState extends State<PrivateClass> {

  int privateClassId;
  String privateClassName;
  String privateClassDesc;
  String privateClassPrice;

  _PrivateClassState(this.privateClassId,this.privateClassName,this.privateClassDesc,this.privateClassPrice);

  Future<PrivateClassCourseEnrollmentListingModel> _privateClassCourseEnrollmentListingModelFuture;
  PrivateClassCourseEnrollmentListingRepository _privateClassCourseEnrollmentListingRepository;
  SharedPreferences prefs;
  String token="";

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString("access_token");
    _privateClassCourseEnrollmentListingRepository = PrivateClassCourseEnrollmentListingRepository();
    _privateClassCourseEnrollmentListingModelFuture = _privateClassCourseEnrollmentListingRepository.PrivateClassCourseEnrollmentListingRepositoryFunction(token);
    setState(() {});
  }

  String _checkboxvalue;
  List<String> dropdown=[];
  bool check = false;
  String course_id="";
  String course_name ="";

  @override
  void initState() {
    createSharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> desc= privateClassDesc.split('\n');
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
      body: FutureBuilder<PrivateClassCourseEnrollmentListingModel>(
          future: _privateClassCourseEnrollmentListingModelFuture,
          builder: (context, snapshot){
            if(snapshot.hasData){
              if(snapshot.data.data!=null){
                if (!check) {
                  check = true;
                  Future.delayed(Duration.zero, () {
                    course_id = snapshot.data.data[0].courseid.toString();
                    course_name = snapshot.data.data[0].courseName;
                    setState(() {});
                  });
                }
                dropdown.clear();
                for(int i=0;i<snapshot.data.data.length;i++){
                  dropdown.add(snapshot.data.data[i].courseName);
                }
                return ListView(
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.03),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: Color.fromRGBO(108, 108, 108, 0.5)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: h * 0.02, left: w * 0.04),
                                child: Text(privateClassName,
                                  style: TextStyle(fontSize: w*0.05,fontWeight: FontWeight.bold,),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: h * 0.02, right: w * 0.04),
                                child: Text('\$ ${privateClassPrice}/Month',
                                  style: TextStyle(fontSize: w*0.04,fontWeight: FontWeight.bold,),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: h * 0.01, left: w * 0.04,right: w*0.04),
                            child: Text(
                              desc[0],
                              style: TextStyle(fontSize: w*0.035,fontWeight: FontWeight.bold,color: Color.fromRGBO(77, 200, 174, 1)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: w * 0.3,right: w*0.04),
                            child: Text(
                              desc[1],
                              style: TextStyle(fontSize: w*0.05,fontWeight: FontWeight.bold,color: Color.fromRGBO(77, 200, 174, 1)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: w * 0.04, bottom: h * 0.02,right: w*0.04),
                            child: Text(
                              desc[2],
                              style: TextStyle(fontSize: w*0.035,fontWeight: FontWeight.bold,color: Color.fromRGBO(77, 200, 174, 1)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.08,right: w*0.08,top: h*0.035),
                      child: Text(
                        'Ideal for student who thrive in 1:1 settings,with classes tailored to their unique learning needs',
                        style: TextStyle(fontSize: w*0.038,color: Colors.black54),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: h*0.03,left: w*0.08),
                          child: Image.asset('images/tick_inside_circle.png',height: h*0.035,),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: h*0.04,left: w*0.05,right: w*0.08),
                            child: Text('1:1 classes with a dedicated,recurring instructor',
                              style: TextStyle(fontSize: w*0.04),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: h*0.03,left: w*0.08),
                          child: Image.asset('images/tick_inside_circle.png',height: h*0.035,),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: h*0.04,left: w*0.05,right: w*0.08),
                            child: Text('Personalized teaching for your child\'s pace and learning style',
                              style: TextStyle(fontSize: w*0.04),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: w*0.08,right: w*0.08,top: h*0.05),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            items: dropdown.map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (String value) {
                              setState(() {
                                _checkboxvalue = value;
                              });
                            },
                            hint: Text('Choose a course',
                                style: TextStyle(color: Colors.black54)),
                            value: _checkboxvalue,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }else{
                return Center(child: Text('No data found'));
              }
            }else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text('Something went wrong please try again'),);
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
          }
      ),
        bottomNavigationBar: check?
        BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: w * 0.05),
                child: Text(
                  '\$ ${privateClassPrice}',
                  style: TextStyle(fontSize: w*0.065, fontWeight: FontWeight.bold, color: Color.fromRGBO(156, 175, 23, 1)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: w * 0.05, top: h * 0.02, bottom: h * 0.02),
                child: RaisedButton(
                  onPressed: () {
                    userLogin==true?
                    _checkboxvalue!=null ?
                    Navigator.push(context,MaterialPageRoute(builder: (context) => PaypalPaymentPrivate(
                        //privateClassId.toString(),
                        course_id,
                        course_name,
                        privateClassPrice
                    )),)
                        :AwesomeDialog(
                        context: context,
                        dismissOnTouchOutside: false,
                        useRootNavigator: true,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.SCALE,
                        title: 'Error!',
                        desc: 'Please choose a course to enroll',
                        btnOkColor: Colors.red,
                        btnOkOnPress: () {}).show()
                        : Navigator.push(context,MaterialPageRoute(builder: (context) => Signin()),);
                  },
                  textColor: Colors.white,
                  padding: EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(156, 175, 23, 1),
                            Color.fromRGBO(84, 201, 165, 1),
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text('Enroll Now',
                        style: TextStyle(fontSize: w*0.05)),
                  ),
                ),
              )
            ],
          ),
        ):null


    );
  }
}
