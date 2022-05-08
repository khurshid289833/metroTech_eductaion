import 'package:flutter/material.dart';
import 'package:metrotech_education/constants.dart';
import 'package:metrotech_education/myCourse/model/myCourseModel.dart';
import 'package:metrotech_education/myCourse/repository/myCourseRepository.dart';
import 'package:metrotech_education/viewcourse/viewcourse.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyCourse extends StatefulWidget {
  @override
  _MyCourseState createState() => _MyCourseState();
}

class _MyCourseState extends State<MyCourse> {

  SharedPreferences prefs;
  String token = "";
  Future<MyCourseModel> _myCoursefuture;
  MyCourseRepository _myCourseRepository;

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString("access_token");
    _myCoursefuture = _myCourseRepository.MyCourseRepositoryFunction(token);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _myCourseRepository = MyCourseRepository();
    createSharedPref();
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
      body: token!=null?
      Container(
        color: Color.fromRGBO(249, 249, 249, 1),
        child: Center(
          child: FutureBuilder<MyCourseModel>(
              future: _myCoursefuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.data != null) {
                    return ListView(
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      //shrinkWrap: true,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: h * 0.02, left: w * 0.04),
                          child: Text(
                            'My Courses',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                fontSize: w*0.045),
                            //GoogleFonts.roboto(fontSize: 18,fontWeight: FontWeight.w500,color: Color.fromRGBO(57, 56, 56, 1)),
                          ),
                        ),
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: h * 0.02),
                            itemCount: snapshot.data.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => ViewCourse(
                                              snapshot.data.data[index].courseId,)));
                                },
                                child: Card(
                                  elevation: 2,
                                  margin: EdgeInsets.only(bottom: h * 0.025),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10)
                                  )),
                                  clipBehavior: Clip.hardEdge,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: w * 0.03,
                                            top: h * 0.015,
                                            bottom: h * 0.015,
                                            right: w * 0.025),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: FadeInImage(
                                            height: h * 0.1,
                                            width: w * 0.2,
                                            placeholder: AssetImage('images/place_holder.png'),
                                            image: NetworkImage("$imageURL${snapshot.data.data[index].courseLogo}"),
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
                                                snapshot.data.data[index].courseName,
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400),
                                              )),
                                          Padding(
                                            padding: EdgeInsets.only(top: h * 0.02),
                                            child: LinearPercentIndicator(
                                              width: 200.0,
                                              lineHeight: 4.5,
                                              percent: 0.5,
                                              backgroundColor: Color.fromRGBO(209, 204, 204, 1),
                                              progressColor: Color.fromRGBO(84, 201, 165, 1),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(left: w * 0.02, top: h * 0.008),
                                              child: Text(
                                                '50% Complete                              8/10',
                                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
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
                  } else {
                    return Text("No data");
                  }
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text("error");
                } else {
                  return CircularProgressIndicator(
                    strokeWidth: 3.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(156, 175, 23, 1),
                    ),
                  );
                }
              }),
        ),
      )
          :Center(child: Text('Please login first to check your enrolled courses'),)
    );
  }
}
