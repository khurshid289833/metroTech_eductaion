import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metrotech_education/constants.dart';
import 'package:metrotech_education/dashboard/model/dashboardModel.dart';
import 'package:metrotech_education/dashboard/repository/dashboardRepository.dart';
import 'package:metrotech_education/main.dart';
import 'package:metrotech_education/myProfile/myProfile.dart';
import 'package:metrotech_education/signin/signin.dart';
import 'package:metrotech_education/signup/signup.dart';
import 'package:metrotech_education/viewcourse/viewcourse.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  List<String> icon = [
    'images/calender.png',
    'images/clock.png',
    'images/certificate.png',
  ];
  List<String> item = [
    'All Courses',
    'Enrolled Courses',
    'Certificates',
  ];

  SharedPreferences _preferences;
  String token="";
  String student_name="";
  String picture = "";

  Future<DashboardModel> _dashboardFuture;
  DashboardRepository _dashboardRepository;

  int localCompletePercentage;

  Future<void> CreateSharedPreference()async{
    _preferences = await SharedPreferences.getInstance();
    token = _preferences.getString("access_token");
    student_name = _preferences.getString("student_name");
    picture = _preferences.getString("student_picture");
    _dashboardRepository = DashboardRepository();
    _dashboardFuture = _dashboardRepository.DashboardRepositoryFunction(token);
    setState(() {});
  }
  @override
  void initState() {
    CreateSharedPreference();
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
              Icon(Icons.arrow_back_rounded, color: Colors.black, size: w*0.065),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()),);
              }),
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.only(top: h*0.009),
            child: Image.asset(
              'images/logo.png',
              fit: BoxFit.contain,
              height: h*0.045,
            ),
          ),
          actions: [
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.notifications_none_outlined,color: Colors.black54,size: w*0.065,),
            ),
            Padding(
              padding: EdgeInsets.only(right: w * 0.04),
              child: InkWell(
                onTap: () {
                  userLogin
                      ? Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile()))
                      : Navigator.push(context, MaterialPageRoute(builder: (context) => Signin()));
                },
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.black26,
                  child: CircleAvatar(
                    radius: 13,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundColor: Colors.black26,
                      radius: 12,
                      backgroundImage: picture==null? AssetImage("images/icon_person.png"):NetworkImage("$imageURL${picture}"),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: token!=null?
      Container(
        color: Color.fromRGBO(249, 249, 249, 1),
        child: FutureBuilder<DashboardModel>(
          future: _dashboardFuture,
          builder: (context,snapshot){
            if(snapshot.hasData){
              if(snapshot.data.data!=null){
                return ListView(
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: w*0.04,top: h*0.02),
                      child: Text("Hello",
                        style: TextStyle(fontSize: w*0.04,color: Color.fromRGBO(112, 112, 112, 1)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: w*0.04,top: h*0.002),
                      child: Text(student_name,
                        style: TextStyle(fontSize: w*0.045,fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      height: h*0.2,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: w*0.04,top: h*0.02),
                            width: w*0.35,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(226, 242, 253, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: w*0.02,top: h*0.02),
                                      child: Image.asset('images/calender.png',height: h*0.07,),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: w*0.035,top: h*0.02),
                                      child: Text(
                                        snapshot.data.data[0].totalCourses.toString(),
                                        style: TextStyle(fontSize: w*0.07,fontWeight: FontWeight.bold,color: Color.fromRGBO(112,  112, 112, 0.8)),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w*0.03,top: h*0.035),
                                  child: Text(
                                    'All Courses',
                                    style: TextStyle(fontSize: w*0.035,fontWeight: FontWeight.w500,color: Color.fromRGBO(4, 109, 180, 0.8)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: w*0.04,top: h*0.02),
                            width: w*0.35,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(247, 237, 221, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: w*0.02,top: h*0.02),
                                      child: Image.asset('images/clock.png',height: h*0.07,),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: w*0.035,top: h*0.02),
                                      child: Text(
                                        snapshot.data.data[0].enrolledCourses.toString(),
                                        style: TextStyle(fontSize: w*0.07,fontWeight: FontWeight.bold,color: Color.fromRGBO(112,  112, 112, 0.8)),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w*0.03,top: h*0.035),
                                  child: Text(
                                    'Enrolled Courses',
                                    style: TextStyle(fontSize: w*0.035,fontWeight: FontWeight.w500,color: Color.fromRGBO(233, 141, 3, 0.8)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: w*0.04,top: h*0.02,right: w*0.04),
                            width: w*0.35,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 224, 224, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: w*0.02,top: h*0.02),
                                      child: Image.asset('images/certificate.png',height: h*0.07,),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: w*0.035,top: h*0.02),
                                      child: Text(
                                        '10',
                                        style: TextStyle(fontSize: w*0.07,fontWeight: FontWeight.bold,color: Color.fromRGBO(112,  112, 112, 0.8)),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w*0.03,top: h*0.035),
                                  child: Text(
                                    'Certificates',
                                    style: TextStyle(fontSize: w*0.035,fontWeight: FontWeight.w500,color: Color.fromRGBO(245, 68, 68, 0.8)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: h * 0.035, left: w * 0.04),
                      child: Text(
                        'My Progress',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: w*0.045),
                      ),
                    ),
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02),
                        itemCount: snapshot.data.data[0].courses.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCourse(snapshot.data.data[0].courses[index].courseId)));
                            },
                            child: Card(
                              elevation: 2,
                              margin: EdgeInsets.only(bottom: h * 0.025),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: w * 0.03, top: h * 0.015, bottom: h * 0.015, right: w * 0.025),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: FadeInImage(
                                        height: h * 0.1,
                                        width: w * 0.2,
                                        placeholder: AssetImage('images/place_holder.png'),
                                        image: NetworkImage("$imageURL${snapshot.data.data[0].courses[index].courseLogo}"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: w * 0.02, top: h * 0.015),
                                          child: Text(
                                            snapshot.data.data[0].courses[index].courseName,
                                            style: TextStyle(fontSize: w*0.04, fontWeight: FontWeight.w400),
                                          )),
                                      Padding(
                                        padding: EdgeInsets.only(top: h * 0.02),
                                        child: LinearPercentIndicator(
                                          width: 200.0,
                                          lineHeight: 4.5,
                                          percent: snapshot.data.data[0].courses[index].completionPercentage/100,
                                          backgroundColor: Color.fromRGBO(209, 204, 204, 1),
                                          progressColor: Color.fromRGBO(84, 201, 165, 1),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: w * 0.02, top: h * 0.008),
                                          child: Text(
                                            '${localCompletePercentage=snapshot.data.data[0].courses[index].completionPercentage.toInt()}% Complete                              '
                                                '${snapshot.data.data[0].courses[index].completedContent}/${snapshot.data.data[0].courses[index].totalContent}',
                                            style: TextStyle(fontSize: w*0.028, fontWeight: FontWeight.w600),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ],
                );
              }else{
                return Center(child: Text('No Data'));
              }
            }else if(snapshot.hasError){
              print(snapshot.error);
              return Center(child: Text('Error'));
            }else{
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
      )
          :Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/back_pic.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
            children:[
              Container(
                margin: EdgeInsets.only(top: h*0.06),
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
                  child: Text('Please login first to see your dashboard.',
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup())),
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
