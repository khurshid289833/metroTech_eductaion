import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:metrotech_education/constants.dart';
import 'package:metrotech_education/course/coursePreview.dart';
import 'package:metrotech_education/course/model/listOfCoursesModel.dart';
import 'package:metrotech_education/course/repository/listOfcoursesRepository.dart';
import 'package:metrotech_education/myCourse/myCourse.dart';
import 'model/listOfCoursesModel.dart';

class ListOfCourses extends StatefulWidget {

  final catid;
  final subcatid;
  final topid;

  ListOfCourses(this.catid, this.subcatid, this.topid);

  @override
  _ListOfCoursesState createState() => _ListOfCoursesState();
}

class _ListOfCoursesState extends State<ListOfCourses> {

  Future<ListOfCoursesModel> _coursefuture;
  ListOfCoursesRepository _courseRepository;
  bool success = false;
  bool streamCheck = false;
  String courseid = "";

  @override
  void initState() {
    super.initState();
    _courseRepository = ListOfCoursesRepository();
    _coursefuture = _courseRepository.getCourse(widget.catid.toString(),widget.subcatid.toString(), widget.topid.toString());
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
              icon: Icon(Icons.arrow_back_rounded, color: Colors.black, size: w*0.065),
              onPressed: () {
                Navigator.pop(context);
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
        ),
      ),
      body: Container(
        color: Color.fromRGBO(249, 249, 249, 1),
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("images/back_pic.png"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: FutureBuilder<ListOfCoursesModel>(
            future: _coursefuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.data != null) {
                  return ListView(
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: w * 0.04,top: h*0.02),
                        child: Text(
                          'List of courses',
                          style: TextStyle(fontSize: w*0.045, fontWeight: FontWeight.w500),
                        ),
                      ),
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          padding: EdgeInsets.all(h*0.018),
                          itemCount: snapshot.data.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                userLogin==true&&snapshot.data.data[index].paymentStatus=="APPROVED"?
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MyCourse()),):
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CoursePreview(snapshot.data.data[index].id.toString(),)),);
                              },
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)
                                )),
                                clipBehavior: Clip.hardEdge,
                                margin: EdgeInsets.only(bottom: h*0.02),
                                child: Padding(
                                  padding: EdgeInsets.only(left: w * 0.02, top: h * 0.01, right: w * 0.03,bottom: h*0.01),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: FadeInImage(
                                            placeholder: AssetImage('images/place_holder.png'),
                                            image: NetworkImage("$imageURL${snapshot.data.data[index].courseLogo}"),
                                            height: h*0.12,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(),
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    snapshot.data.data[index].courseName,
                                                    style: TextStyle(fontSize: w*0.038, fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: w*0.04),
                                                  child: Text(
                                                    '\$ ${snapshot.data.data[index].coursePrice}',
                                                    style: TextStyle(fontSize: w*0.038, fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 4.0),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.people_outline, color: Colors.black54, size: 18),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 4.0),
                                                    child: Text(
                                                      snapshot.data.data[index].authorName,
                                                      style: TextStyle(color: Colors.black54, fontSize: 13.0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: h*0.005),
                                              child: Row(
                                                  children: [
                                                    RatingBarIndicator(
                                                      rating: 4.0,
                                                      itemBuilder: (context, index) => Icon(
                                                        Icons.star,
                                                        color: Color.fromRGBO(249, 160, 27, 1),
                                                      ),
                                                      itemCount: 5,
                                                      itemSize: 16.0,
                                                      direction: Axis.horizontal,
                                                    ),
                                                    Text('4.0 (${1})',
                                                        style: TextStyle(fontSize: 12, color: Colors.black54)),
                                                  ]),
                                            ),
                                            userLogin==true&&snapshot.data.data[index].paymentStatus=="APPROVED"?
                                            Container(
                                              margin: EdgeInsets.only(top: h*0.01,right: w*0.25),
                                              height: h*0.028,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.topRight,
                                                    colors: [
                                                      Color.fromRGBO(156, 175, 23, 1),
                                                      Color.fromRGBO(84, 201, 165, 1),
                                                    ]),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child:  Center(
                                                child: Text(
                                                  'Go to course',
                                                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: w*0.03),
                                                ),
                                              ),
                                            )
                                                :Container(
                                              margin: EdgeInsets.only(top: h*0.01,right: w*0.25),
                                              height: h*0.028,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.topRight,
                                                    colors: [
                                                      Color.fromRGBO(156, 175, 23, 1),
                                                      Color.fromRGBO(84, 201, 165, 1),
                                                    ]),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child:  Center(
                                                child: Text(
                                                  'Go to course preview',
                                                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: w*0.03),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            );
                          }),
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
    );
  }
}
