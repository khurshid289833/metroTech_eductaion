import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:metrotech_education/constants.dart';
import 'package:metrotech_education/course/model/coursePreviewModel.dart';
import 'package:metrotech_education/course/repository/coursePreviewRepository.dart';
import 'package:metrotech_education/payment/paypalPayment.dart';
import 'package:metrotech_education/signin/signin.dart';
import 'package:metrotech_education/topCourses/model/topCoursesModel.dart';
import 'package:metrotech_education/topCourses/repository/topCoursesRepository.dart';
import 'package:metrotech_education/topCourses/topCourses.dart';

class CoursePreview extends StatefulWidget {

  final course_id;
  CoursePreview(this.course_id);

  @override
  _CoursePreviewState createState() => _CoursePreviewState(course_id);
}

class _CoursePreviewState extends State<CoursePreview> {

  final course_id;
  _CoursePreviewState(this.course_id);

  Future<CoursePreviewModel> _coursePreviewFuture;
  CoursePreviewRepository _coursePreviewRepository;
  Future<TopCoursesModel> _topCoursesFuture;
  TopCoursesRepository _topCoursesRepository;
  bool check = false;
  String coursePrice="";
  String course_name ="";
  int pageno = 1;

  @override
  void initState() {
    _coursePreviewRepository = CoursePreviewRepository();
    _coursePreviewFuture = _coursePreviewRepository.CoursePreviewRepositoryFunction(course_id);
    _topCoursesRepository = TopCoursesRepository();
    _topCoursesFuture = _topCoursesRepository.TopCoursesRepositoryFunction(pageno);
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
          child: FutureBuilder<CoursePreviewModel>(
            future: _coursePreviewFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.data != null) {
                  if (!check) {
                    check = true;
                    Future.delayed(Duration.zero, () {
                      coursePrice = snapshot.data.data[0].coursePrice;
                      course_name = snapshot.data.data[0].courseName;
                      setState(() {});
                    });
                  }
                  return ListView(
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: w * 0.04, right: w * 0.04, bottom: h * 0.03,top:h * 0.02),
                        height: h * 0.25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage(
                            placeholder: AssetImage('images/place_holder.png'),
                            image: NetworkImage("$imageURL${snapshot.data.data[0].courseLogo}"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: w * 0.04),
                              child: Text(
                                snapshot.data.data[0].courseName,
                                style: TextStyle(fontSize: w*0.045,fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          RatingBarIndicator(
                            rating: 3.7,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Color.fromRGBO(249, 160, 27, 1),
                            ),
                            itemCount: 5,
                            itemSize: 16.0,
                            direction: Axis.horizontal,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: w*0.04),
                            child: Text(
                                '4.6 (202,123)',
                                style: TextStyle(fontSize: w*0.03, color: Colors.black54)
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: w * 0.04,top: h*0.01),
                              child: Icon(
                                Icons.people_outline,
                                color: Colors.black54,
                              )),
                          Padding(
                            padding: EdgeInsets.only(left: w*0.03,top: h*0.01),
                            child: Text(
                              snapshot.data.data[0].authorName,
                              style: TextStyle(fontSize: w*0.035, color: Colors.black54),
                            ),
                          ),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.only(right: w * 0.04),
                            child: Center(
                              child: Text(
                                '\$ ${snapshot.data.data[0].coursePrice}',
                                style: TextStyle(fontWeight: FontWeight.w600,fontSize: w*0.038),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: w * 0.04, top: h * 0.03),
                        child: Row(
                          children: [
                            Icon(
                              Icons.done,
                                color: Color.fromRGBO(84, 201, 165, 1)
                            ),
                            SizedBox(width: w * 0.05),
                            Text('Certificate of completion'),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: w * 0.04, top: h * 0.01),
                        child: Row(
                          children: [
                            Icon(
                              Icons.done,
                                color: Color.fromRGBO(84, 201, 165, 1)
                            ),
                            SizedBox(width: w * 0.05),
                            Text('Full lifetime access'),
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: w * 0.04, top: h * 0.04),
                        child: Text(
                          'Syllabus: what you will learn in this course',
                          style: TextStyle(fontSize: w*0.045, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: snapshot.data.data[0].courseContent.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(height: 20.0),
                                ExpansionTile(
                                  trailing: Icon(Icons.keyboard_arrow_down_sharp,size: w*0.07,color: Color.fromRGBO(67, 196, 185, 1),),
                                  title: Text(
                                    snapshot.data.data[0].courseContent[index].courseContentName,
                                    style: TextStyle(
                                      fontSize: w*0.04,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                      //color: Color.fromRGBO(67, 196, 185, 1),
                                    ),
                                  ),
                                  children: <Widget>[
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        itemCount: snapshot.data.data[0].courseContent[index].courseContentDetails.length,
                                        itemBuilder: (context, index1) {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                  alignment: Alignment.topLeft,
                                                  padding: EdgeInsets.only(left: w * 0.15),
                                                  child: Text(
                                                    snapshot.data.data[0].courseContent[index].courseContentDetails[index1].courseContentDetailsName,
                                                    style: TextStyle(fontSize: w*0.045, color: Colors.black54),
                                                  )),
                                              (index1 < snapshot.data.data[0].courseContent[index].courseContentDetails.length - 1)
                                                  ? Container(
                                                      height: h*0.045,
                                                      alignment: Alignment.topLeft,
                                                      padding: EdgeInsets.only(left: w * 0.15),
                                                      child: VerticalDivider(
                                                        thickness: 2,
                                                        color: Color.fromRGBO(67, 196, 185, 1),
                                                      ),
                                                    )
                                                  : Container(
                                                      margin: EdgeInsets.only(bottom: h * 0.02),
                                                    ),
                                            ],
                                          );
                                        })
                                  ],
                                ),
                              ],
                            );
                          }),


                      // Row(
                      //   children: [
                      //     Padding(
                      //       padding: EdgeInsets.only(top: h * 0.02, left: w * 0.03),
                      //       child: Text(
                      //         'Student also viewed',
                      //         style: TextStyle(fontSize: w*0.045, fontWeight: FontWeight.bold),
                      //       ),
                      //     ),
                      //     Spacer(),
                      //     Padding(
                      //       padding: EdgeInsets.only(top: h * 0.02, right: w * 0.03),
                      //       child: Text(
                      //         'See all',
                      //         style: TextStyle(fontSize: w*0.038, fontWeight: FontWeight.bold, color: Colors.black54),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // ListView.builder(
                      //   scrollDirection: Axis.vertical,
                      //   physics: ScrollPhysics(),
                      //   shrinkWrap: true,
                      //   itemCount: images1.length,
                      //   itemBuilder: (context, index) {
                      //     return Padding(
                      //       padding: EdgeInsets.only(left: w * 0.02, top: h * 0.02, right: w * 0.03),
                      //       child: Row(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: <Widget>[
                      //           Expanded(
                      //             flex: 3,
                      //             child: ClipRRect(
                      //               borderRadius: BorderRadius.circular(10),
                      //               child: Image.asset(
                      //                 images1[index],
                      //                 height: h * 0.11,
                      //               ),
                      //             ),
                      //           ),
                      //           VerticalDivider(),
                      //           Expanded(
                      //             flex: 6,
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: <Widget>[
                      //                 Text(
                      //                   courseName[index],
                      //                   style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w600),
                      //                 ),
                      //                 Padding(
                      //                   padding: EdgeInsets.only(top: 4.0),
                      //                   child: Row(
                      //                     children: [
                      //                       Icon(Icons.people_outline, color: Colors.black54, size: 18),
                      //                       Padding(
                      //                         padding: EdgeInsets.only(left: 4.0),
                      //                         child: Text(
                      //                           author[index],
                      //                           style: TextStyle(color: Colors.black54, fontSize: 13.0),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 Row(children: [
                      //                   Icon(Icons.star, color: Colors.orange, size: 15),
                      //                   Text('4.6 (20,123)',
                      //                       style: TextStyle(fontSize: 12, color: Colors.black54)),
                      //                 ]),
                      //               ],
                      //             ),
                      //           ),
                      //           Expanded(
                      //             flex: 2,
                      //             child: Container(
                      //               height: h * 0.03,
                      //               width: w * 0.16,
                      //               margin: EdgeInsets.only(left: 5),
                      //               decoration: BoxDecoration(
                      //                 gradient: LinearGradient(
                      //                     begin: Alignment.topLeft,
                      //                     end: Alignment.topRight,
                      //                     colors: [
                      //                       Color.fromRGBO(156, 175, 23, 1),
                      //                       Color.fromRGBO(84, 201, 165, 1),
                      //                     ]),
                      //                 borderRadius: BorderRadius.circular(10),
                      //               ),
                      //               child: Center(
                      //                 child: Text(
                      //                   '\$ 433',
                      //                   style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      //   },
                      // ),
                      FutureBuilder<TopCoursesModel>(
                          future: _topCoursesFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.courses != null) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: h * 0.03, left: w * 0.04,bottom: h*0.01),

                                          child: Text(
                                            'Top Courses',
                                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: h * 0.03, right: w * 0.04,bottom: h*0.01),
                                          child: InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => TopCourses()));
                                            },
                                            child: Text(
                                              'See all',
                                              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black54),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      physics: ScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(left: w*0.02,right: w*0.02),
                                      itemCount: snapshot.data.courses.data.length<5?snapshot.data.courses.data.length:5,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => CoursePreview(snapshot.data.courses.data[index].id.toString())),);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(left: w * 0.02, top: h * 0.02, right: w * 0.03),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 3,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: FadeInImage(
                                                      placeholder: AssetImage('images/place_holder.png'),
                                                      image: NetworkImage("$imageURL${snapshot.data.courses.data[index].courseLogo}"),
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
                                                              snapshot.data.courses.data[index].courseName,
                                                              style: TextStyle(fontSize: w*0.038, fontWeight: FontWeight.w600),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(left: w*0.04),
                                                            child: Text(
                                                              '\$ ${snapshot.data.courses.data[index].coursePrice}',
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
                                                                snapshot.data.courses.data[index].author,
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
                                                                rating: double.parse(snapshot.data.courses.data[index].rating),
                                                                itemBuilder: (context, index) => Icon(
                                                                  Icons.star,
                                                                  color: Color.fromRGBO(249, 160, 27, 1),
                                                                ),
                                                                itemCount: 5,
                                                                itemSize: 16.0,
                                                                direction: Axis.horizontal,
                                                              ),
                                                              Text('${snapshot.data.courses.data[index].rating} (${snapshot.data.courses.data[index].rating})',
                                                                  style: TextStyle(fontSize: 12, color: Colors.black54)),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            } else if (snapshot.hasError) {
                              print(snapshot.error);
                              return Container();
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
                      SizedBox(height: h * 0.03),

                    ],
                  );
                } else {
                  return Center(child: Text('No data'));
                }
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text('error'));
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
            },
          ),
        ),
        bottomNavigationBar: check
            ? BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: w * 0.05),
                      child: Text(
                        '\$ ${coursePrice}',
                        style: TextStyle(fontSize: w*0.065, fontWeight: FontWeight.bold, color: Color.fromRGBO(156, 175, 23, 1)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: w * 0.05, top: h * 0.02, bottom: h * 0.02),
                      child: RaisedButton(
                        onPressed: () {
                          userLogin
                              ? Navigator.push(context,MaterialPageRoute(builder: (context) => PaypalPayment(course_id,course_name,coursePrice)),)
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
              )
            : null
    );
  }
}
