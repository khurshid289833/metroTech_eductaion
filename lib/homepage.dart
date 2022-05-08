import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:metrotech_education/categories/categories.dart';
import 'package:metrotech_education/categories/model/categoriesModel.dart';
import 'package:metrotech_education/categories/repository/categoriesRepository.dart';
import 'package:metrotech_education/categories/subtop.dart';
import 'package:metrotech_education/classes/private.dart';
import 'package:metrotech_education/classes/pro.dart';
import 'package:metrotech_education/constants.dart';
import 'package:metrotech_education/course/coursePreview.dart';
import 'package:metrotech_education/homepageCourseDisplay/homePageCourseDisplay.dart';
import 'package:metrotech_education/homepageCourseDisplay/model/homepageCourseDisplayModel.dart';
import 'package:metrotech_education/homepageCourseDisplay/repository/homepageCourseDisplayRepository.dart';
import 'package:metrotech_education/homepagePrivateClassListing/model/homepagePrivateClassListingModel.dart';
import 'package:metrotech_education/homepagePrivateClassListing/repository/homepagePrivateClassListingRepository.dart';
import 'package:metrotech_education/myProfile/myProfile.dart';
import 'package:metrotech_education/search/model/searchModel.dart';
import 'package:metrotech_education/search/repository/searchRepository.dart';
import 'package:metrotech_education/signin/signin.dart';
import 'package:metrotech_education/topCourses/model/topCoursesModel.dart';
import 'package:metrotech_education/topCourses/repository/topCoursesRepository.dart';
import 'package:metrotech_education/topCourses/topCourses.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<CategoriesModel> _getCategories;
  CategoriesRepository _getCategoriesRepository;

  Future<HomepageCourseDisplayModel> _homePageCourseDisplayFuture;
  HomepageCourseDisplayRepository _homepageCourseDisplayRepository;

  Future<TopCoursesModel> _topCoursesFuture;
  TopCoursesRepository _topCoursesRepository;

  Future<HomepagePrivateClassListingModel> _homepagePrivateClassListingFuture;
  HomepagePrivateClassListingRepository _homepagePrivateClassListingRepository;

  Future<SearchModel> _searchFuture;
  SearchRepository _searchRepository;

  TextEditingController searchController = TextEditingController();
  bool isBlank = true;

  SharedPreferences prefs;
  String picture = "";
  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    picture = prefs.getString("student_picture");
    setState(() {});
  }
  int pageno = 1;
  @override
  void initState() {
    createSharedPref();
    _getCategoriesRepository = CategoriesRepository();
    _getCategories = _getCategoriesRepository.getCategories();
    _homepageCourseDisplayRepository = HomepageCourseDisplayRepository();
    _homePageCourseDisplayFuture = _homepageCourseDisplayRepository.HomepageCourseDisplayRepositoryFunction(pageno);
    _topCoursesRepository = TopCoursesRepository();
    _topCoursesFuture = _topCoursesRepository.TopCoursesRepositoryFunction(pageno);
    _homepagePrivateClassListingRepository = HomepagePrivateClassListingRepository();
    _homepagePrivateClassListingFuture = _homepagePrivateClassListingRepository.HomepagePrivateClassListingRepositoryFunction();
    _searchRepository = SearchRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(h * 0.15),
          child: Stack(
            children: [
              AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.01),
                      child: Image.asset('images/logo.png', height: h * 0.045,),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: w * 0.01,),
                      child: InkWell(
                        onTap: () {
                          userLogin
                              ? Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile()))
                              : Navigator.push(context, MaterialPageRoute(builder: (context) => Signin()));
                        },
                        child: CircleAvatar(
                          radius: 17,
                          backgroundColor: Colors.black26,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                                backgroundColor: Colors.black26,
                                radius: 15,
                                backgroundImage: picture!=null? NetworkImage("$imageURL${picture}"):AssetImage("images/icon_person.png")
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: h * 0.116, bottom: h * 0.015),
                child: TextFormField(
                  cursorColor: Colors.black26,
                  controller: searchController,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        isBlank = true;
                      });
                    } else if (value.length > 2) {
                      _searchFuture = _searchRepository.SearchRepositoryFunction(value);
                      setState(() {
                        isBlank = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: Icon(Icons.search, color: Colors.black54),
                    filled: true,
                    fillColor: Color.fromRGBO(240, 241, 243, 1),
                    suffixIcon: isBlank
                        ? null
                        : InkWell(
                            onTap: () {
                              searchController.clear();
                              setState(() {
                                isBlank = true;
                              });
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.black54,
                              size: 20,
                            ),
                          ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(201, 208, 215, 1),),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(201, 208, 215, 1)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'Search courses',
                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.black54),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: isBlank
            ? ListView(
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageCourseDisplay()));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                      child: Image.asset("images/banner.png"),
                    ),
                  ),
                  FutureBuilder<CategoriesModel>(
                      future: _getCategories,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.data != null) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: h * 0.02, left: w * 0.03,),
                                      child: Text(
                                        'Categories',
                                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: h * 0.02, right: w * 0.03),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Categories()));
                                        },
                                        child: Text(
                                          'More',
                                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black54),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.data.length,
                                  padding: EdgeInsets.only(left: w*0.02,right: w*0.02,top: h*0.02),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 6.0,
                                    mainAxisSpacing: 15.0,
                                    childAspectRatio: 0.9 / 1,
                                  ),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => SubTop(
                                            snapshot.data.data[index].id.toString(),
                                            snapshot.data.data[index].subcategory)));
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        elevation: 2,
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: FadeInImage(
                                                placeholder: AssetImage('images/place_holder.png'),
                                                image: NetworkImage("$imageURL${snapshot.data.data[index].categoryLogo}"),
                                                height: h,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color.fromRGBO(0, 0, 0, 0),
                                                      Color.fromRGBO(0, 0, 0, 0.85),
                                                    ],
                                                  )),
                                            ),
                                            Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: w * 0.025, bottom: h * 0.015),
                                                  child: Text(
                                                    snapshot.data.data[index].categoryName,
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                                                  ),
                                                )),
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
                  FutureBuilder<HomepageCourseDisplayModel>(
                      future: _homePageCourseDisplayFuture,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.courses != null) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: h * 0.03, left: w * 0.03,bottom: h*0.01),
                                      child: Text(
                                        'Courses we offer',
                                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: h * 0.03, right: w * 0.03,bottom: h*0.01),
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageCourseDisplay()));
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
                                  padding: EdgeInsets.only(left: w*0.01,right: w*0.01,),
                                  itemCount: snapshot.data.courses.data.length,
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
                                                        rating: double.parse(snapshot.data.courses.data[index].courseRating),
                                                        itemBuilder: (context, index) => Icon(
                                                          Icons.star,
                                                          color: Color.fromRGBO(249, 160, 27, 1),
                                                        ),
                                                        itemCount: 5,
                                                        itemSize: 16.0,
                                                        direction: Axis.horizontal,
                                                      ),
                                                      Text('${snapshot.data.courses.data[index].courseRating} (${snapshot.data.courses.data[index].courseReview})',
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
                                      padding: EdgeInsets.only(top: h * 0.03, left: w * 0.03,bottom: h*0.01),
                                      child: Text(
                                        'Top Courses',
                                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: h * 0.03, right: w * 0.03,bottom: h*0.01),
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
                                  padding: EdgeInsets.only(left: w*0.01,right: w*0.01),
                                  itemCount: snapshot.data.courses.data.length,
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Padding(
                  //       padding: EdgeInsets.only(top: h * 0.03, left: w * 0.03),
                  //       child: Text(
                  //         'Most popular Certificates',
                  //         style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: EdgeInsets.only(top: h * 0.03, right: w * 0.03),
                  //       child: Text(
                  //         'See all',
                  //         style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black54),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Container(
                  //   height: h * 0.32,
                  //   margin: EdgeInsets.only(left: w * 0.01, top: h * 0.02),
                  //   child: ListView.builder(
                  //       shrinkWrap: true,
                  //       scrollDirection: Axis.horizontal,
                  //       physics: ScrollPhysics(),
                  //       itemCount: courseName.length,
                  //       itemBuilder: (context, index) {
                  //         return Container(
                  //           width: w * 0.55,
                  //           margin: EdgeInsets.only(left: 8.0, right: 8.0),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               ClipRRect(
                  //                 borderRadius: BorderRadius.circular(10.0),
                  //                 child: Image.asset(images[index]),
                  //               ),
                  //               Padding(
                  //                 padding: EdgeInsets.only(top: h * 0.008, right: 5, left: 5),
                  //                 child: Text(
                  //                   courseName[index],
                  //                   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  //                 ),
                  //               ),
                  //               Row(
                  //                 children: [
                  //                   Padding(
                  //                     padding: EdgeInsets.only(left: 5),
                  //                     child: Icon(
                  //                       Icons.people_outline,
                  //                       color: Colors.black54,
                  //                     ),
                  //                   ),
                  //                   Padding(
                  //                     padding: EdgeInsets.only(left: 5.0),
                  //                     child: Text(
                  //                       author[index],
                  //                       style: TextStyle(fontSize: 14, color: Colors.black54),
                  //                     ),
                  //                   )
                  //                 ],
                  //               ),
                  //               Row(
                  //                 children: [
                  //                   Padding(
                  //                     padding: const EdgeInsets.only(left: 5),
                  //                     child: Icon(Icons.star, color: Colors.orange, size: 15),
                  //                   ),
                  //                   Padding(
                  //                     padding: const EdgeInsets.only(left: 5.0),
                  //                     child: Text('4.6 (202,123)',
                  //                         style: TextStyle(fontSize: 12, color: Colors.black54)),
                  //                   )
                  //                 ],
                  //               ),
                  //               // Spacer(),
                  //               Container(
                  //                 height: h * 0.03,
                  //                 width: w * 0.16,
                  //                 margin: EdgeInsets.only(top: h * 0.01, left: 5, bottom: 12,),
                  //                 decoration: BoxDecoration(
                  //                   gradient: LinearGradient(
                  //                       begin: Alignment.topLeft,
                  //                       end: Alignment.topRight,
                  //                       colors: [
                  //                         Color.fromRGBO(156, 175, 23, 1),
                  //                         Color.fromRGBO(84, 201, 165, 1),
                  //                       ]),
                  //                   borderRadius: BorderRadius.circular(10),
                  //                 ),
                  //                 child: Padding(
                  //                   padding: EdgeInsets.only(left: w * 0.025, top: h * 0.004),
                  //                   child: Text(
                  //                     '\$ 433',
                  //                     style: TextStyle(color: Colors.white),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         );
                  //       }),
                  // ),
                  FutureBuilder<HomepagePrivateClassListingModel>(
                      future: _homepagePrivateClassListingFuture,
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          if(snapshot.data.data!=null){
                            return  Container(
                              margin: EdgeInsets.only(top: h*0.02),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("images/back_pic_dark.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: w*0.03,top: h*0.02),
                                    child: Text("Get Subscription and Unlock More",
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.04),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: w*0.03,top: h*0.005),
                                    child: Text("We take our mission of increasing global access to quality education seriously.",
                                      style: TextStyle(fontWeight: FontWeight.w500,fontSize: w*0.025),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: w*0.03),
                                    child: Text("We connect learners to the best universities and institutions from around the world.",
                                      style: TextStyle(fontWeight: FontWeight.w500,fontSize: w*0.025),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: h*0.04,left: w*0.25),
                                        child: Image.asset('images/tick_inside_circle.png',height: h*0.025,),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: h*0.04,left: w*0.03),
                                        child: Text('Best Educators',
                                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: w*0.04),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: h*0.015,left: w*0.25),
                                        child: Image.asset('images/tick_inside_circle.png',height: h*0.025,),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: h*0.015,left: w*0.03),
                                        child: Text('1:1 Private classes',
                                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: w*0.04),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: h*0.015,left: w*0.25),
                                        child: Image.asset('images/tick_inside_circle.png',height: h*0.025,),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: h*0.015,left: w*0.03),
                                        child: Text('Open group classes',
                                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: w*0.04),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    padding: EdgeInsets.only(left: w*0.05,top: h*0.04,right: w*0.05),
                                    itemCount: snapshot.data.data.length,
                                    itemBuilder: (context,index) {
                                      return InkWell(
                                        onTap: (){
                                          userLogin==true?
                                              index==0?
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivateClass(
                                            snapshot.data.data[index].id,
                                            snapshot.data.data[index].privateClassName,
                                            snapshot.data.data[index].privateClassDesc,
                                            snapshot.data.data[index].price,
                                          )))
                                              :  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProClass(
                                                snapshot.data.data[index].id,
                                                snapshot.data.data[index].privateClassName,
                                                snapshot.data.data[index].privateClassDesc,
                                                snapshot.data.data[index].price,
                                              )))
                                              : Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin()));
                                        },
                                        child: Container(
                                          height: h*0.07,
                                          margin: EdgeInsets.only(bottom: h*0.015),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left: w*0.05),
                                                child: Text(snapshot.data.data[index].privateClassName.toUpperCase(),
                                                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: w*0.04),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(right: w*0.02),
                                                    child: Text('\$ ${snapshot.data.data[index].price}/mo',
                                                      style: TextStyle(fontWeight: FontWeight.w500,fontSize: w*0.042),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(right: w*0.05),
                                                    child: Icon(Icons.arrow_forward_ios_sharp,size: w*0.045,),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          }else{
                            return Container();
                          }
                        }else if (snapshot.hasError) {
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
                      }
                  ),
                ],
              )
            : Container(
                height: h,
                width: w,
                child: Center(
                  child: FutureBuilder<SearchModel>(
                      future: _searchFuture,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.data != null) {
                            return ListView(
                              scrollDirection: Axis.vertical,
                              physics: ScrollPhysics(),
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: h * 0.02, left: w * 0.04,bottom: h*0.01),
                                  child: Text(
                                    'Total course found : ${snapshot.data.totalFound}',
                                    style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400, fontSize: w * 0.05),
                                  ),
                                ),
                                ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemCount: snapshot.data.data[0].result.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          //userLogin==true&&snapshot.data.data[index].paymentStatus=="APPROVED"?
                                          //Navigator.push(context, MaterialPageRoute(builder: (context) => MyCourse()),):
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => CoursePreview(snapshot.data.data[0].result[index].id.toString(),)),);
                                        },
                                        child: Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10)
                                              )),
                                          clipBehavior: Clip.hardEdge,
                                          margin: EdgeInsets.only(top: h*0.01,right: w*0.04,left: w*0.04,bottom: h*0.01),
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
                                                      image: NetworkImage("$imageURL${snapshot.data.data[0].result[index].courseLogo}"),
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
                                                              snapshot.data.data[0].result[index].courseName,
                                                              style: TextStyle(fontSize: w*0.038, fontWeight: FontWeight.w600),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(left: w*0.04),
                                                            child: Text(
                                                              '\$ ${snapshot.data.data[0].result[index].coursePrice}',
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
                                                                snapshot.data.data[0].result[index].author,
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
                                                                rating:  snapshot.data.data[0].result[index].rating!=null?double.parse(snapshot.data.data[0].result[index].rating):0.0,
                                                                itemBuilder: (context, index) => Icon(
                                                                  Icons.star,
                                                                  color: Color.fromRGBO(249, 160, 27, 1),
                                                                ),
                                                                itemCount: 5,
                                                                itemSize: 16.0,
                                                                direction: Axis.horizontal,
                                                              ),
                                                              Text('${snapshot.data.data[0].result[index].rating!=null?snapshot.data.data[0].result[index].rating:0.0} (466)',
                                                                  style: TextStyle(fontSize: 12, color: Colors.black54)),
                                                            ]),
                                                      ),
                                                      // userLogin==true&&snapshot.data.data[index].paymentStatus=="APPROVED"?
                                                      // Container(
                                                      //   margin: EdgeInsets.only(top: h*0.01,right: w*0.25),
                                                      //   height: h*0.028,
                                                      //   decoration: BoxDecoration(
                                                      //     gradient: LinearGradient(
                                                      //         begin: Alignment.topLeft,
                                                      //         end: Alignment.topRight,
                                                      //         colors: [
                                                      //           Color.fromRGBO(156, 175, 23, 1),
                                                      //           Color.fromRGBO(84, 201, 165, 1),
                                                      //         ]),
                                                      //     borderRadius: BorderRadius.circular(10),
                                                      //   ),
                                                      //   child:  Center(
                                                      //     child: Text(
                                                      //       'Go to course',
                                                      //       style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: w*0.03),
                                                      //     ),
                                                      //   ),
                                                      // )
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
                                    // }),
                              ],
                            );
                          } else {
                            return Text("No data found");
                          }
                        } else if (snapshot.hasData) {
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
              ));
  }
}
