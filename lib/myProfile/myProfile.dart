import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:metrotech_education/api_base/api_response.dart';
import 'package:metrotech_education/changePassword/changePassword.dart';
import 'package:metrotech_education/constants.dart';
import 'package:metrotech_education/logout/bloc/logoutBloc.dart';
import 'package:metrotech_education/logout/model/logoutModel.dart';
import 'package:metrotech_education/main.dart';
import 'package:metrotech_education/myCourse/myCourse.dart';
import 'package:metrotech_education/myProfile/model/getProfileDataModel.dart';
import 'package:metrotech_education/myProfile/profileEdit.dart';
import 'package:metrotech_education/myProfile/repository/getProfileDataRepository.dart';
import 'package:metrotech_education/signin/signin.dart';
import 'package:metrotech_education/signup/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  LogoutBloc _logoutBloc;
  SharedPreferences prefs;
  bool streamCheck = false;
  String token = "";
  String name = "";
  String email = "";
  String picture = "";

  Future<GetProfileDataModel> _getProfileDataFuture;
  GetProfileDataRepository _getProfileDataRepository;


  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString("access_token");
    _getProfileDataRepository = GetProfileDataRepository();
    _getProfileDataFuture = _getProfileDataRepository.GetProfileDataRepositoryFunction(token);
    setState(() {});
  }

  @override
  void initState() {
    _logoutBloc = LogoutBloc();
    createSharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: token!=null?
      FutureBuilder<GetProfileDataModel>(
          future: _getProfileDataFuture,
          builder: (context, snapshot){
            if(snapshot.hasData){
              if(snapshot.data.data!=null){
                prefs.setString('student_picture', snapshot.data.data[0].profilePic);
                return ListView(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    Container(
                      height: h * 0.45,
                      margin: EdgeInsets.only(bottom: h * 0.02),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('images/profile_bg.png'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      child: ListView(
                        children: [
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: h * 0.018, left: w * 0.04),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()),
                                      );
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                  )),
                              Padding(
                                  padding:
                                  EdgeInsets.only(top: h * 0.018, left: w * 0.02),
                                  child: Text(
                                    'Profile',
                                    style: TextStyle(
                                        fontSize: w * 0.045,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: h * 0.02),
                            child: CircleAvatar(
                              radius: w * 0.14,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: w * 0.138,
                                backgroundImage: snapshot.data.data[0].profilePic==null? AssetImage("images/icon_person.png"):NetworkImage("$imageURL${snapshot.data.data[0].profilePic}"),
                                //child:Image.asset('images/java.png'),
                              ),
                            ),
                          ),
                          Center(
                              child: Padding(
                                  padding: EdgeInsets.only(top: h * 0.025),
                                  child: Text(
                                    snapshot.data.data[0].uniqueId,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: w * 0.045),
                                  ))),
                          Center(
                              child: Padding(
                                  padding: EdgeInsets.only(top: h * 0.005),
                                  child: Text(
                                    snapshot.data.data[0].fullname,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: w * 0.045),
                                  ))),
                          Center(
                              child: Padding(
                                  padding:
                                  EdgeInsets.only(top: h * 0.005, bottom: h * 0.01),
                                  child: Text(
                                    snapshot.data.data[0].email,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: w * 0.038,
                                        color: Color.fromRGBO(217, 214, 214, 1)),
                                  ))),
                          Center(
                              child: Padding(
                                  padding:
                                  EdgeInsets.only(bottom: h * 0.02),
                                  child: Text(
                                    snapshot.data.data[0].phoneno,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: w * 0.038,
                                        color: Color.fromRGBO(217, 214, 214, 1)),
                                  ))),
                          Container(
                            padding: EdgeInsets.only(left: w * 0.42, right: w * 0.42),
                            height: h * 0.035,
                            child: RaisedButton(
                              child: Text(
                                "EDIT",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: w * 0.03),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide(color: Colors.white)),
                              elevation: 0.002,
                              color: Color.fromRGBO(255, 255, 255, 0.2),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEdit(
                                    snapshot.data.data[0].dateOfBirth,
                                    snapshot.data.data[0].alternateNumber,
                                    snapshot.data.data[0].alternateEmail,
                                    snapshot.data.data[0].country,
                                    snapshot.data.data[0].state,
                                    snapshot.data.data[0].city,
                                    snapshot.data.data[0].zipcode,
                                    snapshot.data.data[0].fullAddress,
                                    snapshot.data.data[0].bio,
                                    snapshot.data.data[0].instituteName,
                                    snapshot.data.data[0].instituteAddress,
                                    snapshot.data.data[0].passoutYear,
                                    snapshot.data.data[0].latestQualification
                                ))).then((value) => {initState()});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyCourse()),);
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: w * 0.05, bottom: h * 0.015, top: h * 0.01),
                            child: Image.asset(
                              'images/icon_mycourse.png',
                              height: h * 0.025,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: w * 0.035, bottom: h * 0.015, top: h * 0.01),
                            child: Text(
                              'My Courses',
                              style: TextStyle(
                                  fontSize: w * 0.04,
                                  color: Color.fromRGBO(112, 112, 112, 1)),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(
                                right: w * 0.05, bottom: h * 0.015, top: h * 0.01),
                            child: Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Color.fromRGBO(112, 112, 112, 1),
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
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: w * 0.05, top: h * 0.015, bottom: h * 0.015),
                          child: Image.asset(
                            'images/icon_notification.png',
                            height: h * 0.025,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: w * 0.035, top: h * 0.015, bottom: h * 0.015),
                          child: Text(
                            'Notification',
                            style: TextStyle(
                                fontSize: w * 0.04,
                                color: Color.fromRGBO(112, 112, 112, 1)),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(
                              right: w * 0.05, top: h * 0.015, bottom: h * 0.015),
                          child: Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Color.fromRGBO(112, 112, 112, 1),
                            size: w * 0.04,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Color.fromRGBO(209, 204, 204, 0.5),
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: w * 0.05, top: h * 0.015, bottom: h * 0.015),
                          child: Image.asset(
                            'images/icon_settings.png',
                            height: h * 0.025,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: w * 0.035, top: h * 0.015, bottom: h * 0.015),
                          child: Text(
                            'Settings',
                            style: TextStyle(
                                fontSize: w * 0.04,
                                color: Color.fromRGBO(112, 112, 112, 1)),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(
                              right: w * 0.05, top: h * 0.015, bottom: h * 0.015),
                          child: Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Color.fromRGBO(112, 112, 112, 1),
                            size: w * 0.04,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Color.fromRGBO(209, 204, 204, 0.5),
                      thickness: 1,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChangePassword()),
                        );
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: w * 0.05, top: h * 0.015, bottom: h * 0.015),
                            child: Image.asset(
                              'images/icon_password.png',
                              height: h * 0.025,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: w * 0.035, top: h * 0.015, bottom: h * 0.015),
                            child: Text(
                              'Change Password',
                              style: TextStyle(
                                  fontSize: w * 0.04,
                                  color: Color.fromRGBO(112, 112, 112, 1)),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(
                                right: w * 0.05, top: h * 0.015, bottom: h * 0.015),
                            child: Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Color.fromRGBO(112, 112, 112, 1),
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
                        AwesomeDialog(
                            context: context,
                            dismissOnTouchOutside: false,
                            useRootNavigator: true,
                            dialogType: DialogType.WARNING,
                            animType: AnimType.SCALE,
                            title: 'Warning!',
                            desc: 'Are you sure you want to logout',
                            btnOkColor: Colors.red,
                            btnOkText: 'Yes',
                            btnCancelColor: Colors.green,
                            btnCancelText: 'No',
                            btnCancelOnPress: (){},
                            btnOkOnPress: () {
                              _logoutBloc.logoutBlocFunction(token);
                              streamCheck = true;
                              showDialog(
                                useRootNavigator: false,
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => Center(
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color.fromRGBO(84, 201, 165, 1),
                                      )),
                                ),
                              );
                            }).show();

                      },
                      child: StreamBuilder<ApiResponse<LogoutModel>>(
                          stream: _logoutBloc.logoutStream,
                          builder: (context, snapshot) {
                            if (streamCheck) {
                              if (snapshot.hasData) {
                                switch (snapshot.data.status) {
                                  case Status.LOADING:
                                    return Container();
                                    break;

                                  case Status.COMPLETED:
                                    streamCheck = false;
                                    if (snapshot.data.data.message == "Successfully logged out") {
                                      userLogin = false;
                                      prefs.remove('student_picture');
                                      prefs.remove('access_token');
                                      prefs.remove('student_name');
                                      Future.delayed(Duration.zero, () async {
                                        AwesomeDialog(
                                            context: context,
                                            dismissOnTouchOutside: false,
                                            useRootNavigator: true,
                                            dialogType: DialogType.SUCCES,
                                            animType: AnimType.SCALE,
                                            title: 'Success!',
                                            desc: 'You have successfully logged out',
                                            btnOkOnPress: () {
                                              Navigator.of(context).pushNamedAndRemoveUntil('/Home', ModalRoute.withName('/MyApp'));
                                            }).show();
                                      });
                                      print("api call done");
                                    }
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
                                          desc: 'You have already logged out',
                                          btnOkColor: Colors.red,
                                          btnOkOnPress: () {
                                            Navigator.pop(context);
                                          }).show();

                                    });
                                    print("api call not done");
                                    break;
                                }
                              }
                            }
                            return Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: h * 0.008, left: w * 0.05, bottom: h * 0.008),
                                  child: Image.asset(
                                    'images/icon_logout.png',
                                    height: h * 0.025,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: h * 0.008, left: w * 0.035, bottom: h * 0.008),
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(fontSize: w * 0.04, color: Color.fromRGBO(112, 112, 112, 1)),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(top: h * 0.008, right: w * 0.05, bottom: h * 0.008),
                                  child: Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    color: Color.fromRGBO(112, 112, 112, 1),
                                    size: w * 0.04,
                                  ),
                                ),
                              ],
                            );
                          }),
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
      ):
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/back_pic.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
            children:[
              Container(
                margin: EdgeInsets.only(top: h*0.1),
                child: Center(child: Text('Oops! You are logged out',
                  style: TextStyle(fontSize: w*0.038,color: Color.fromRGBO(108, 108, 108, 1)),
                )),
              ),
              Container(
                margin: EdgeInsets.only(top: h*0.05),
                child: Image.asset("images/sad_logout.png",height: h*0.12,),
              ),
              Container(
                margin: EdgeInsets.only(top: h*0.07),
                child: Center(
                  child: Text('Please login first to see your profile.',
                    style: TextStyle(fontSize: w*0.036,fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                height: h*0.05,
                margin: EdgeInsets.only(left: w * 0.3, right: w * 0.3, top: h * 0.04),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(84, 201, 165, 1),
                        Color.fromRGBO(156, 175, 23, 1)
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(80.0))),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Signin()),);
                  },
                  child: Center(
                    child: Text(
                      'Login Now',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: w*0.045),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: w * 0.32, right: w * 0.3,top: h*0.02),
                child: Row(
                  children: [
                    Text(
                      'New here? ',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: w * 0.037,
                          fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Signup())),
                      },
                      child: Text(
                        'REGISTER',
                        style: TextStyle(
                            color: Color.fromRGBO(77, 200, 174, 1),
                            fontSize: w * 0.035,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ]
        ),
      )
    );
  }
}
