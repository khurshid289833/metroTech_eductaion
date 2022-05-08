import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:metrotech_education/constants.dart';
import 'package:metrotech_education/course/coursePreview.dart';
import 'package:metrotech_education/topCourses/model/topCoursesModel.dart';
import 'package:metrotech_education/topCourses/repository/topCoursesRepository.dart';

class TopCourses extends StatefulWidget {
  @override
  _TopCoursesState createState() => _TopCoursesState();
}

class _TopCoursesState extends State<TopCourses> {

  Future<TopCoursesModel> _topCoursesFuture;
  TopCoursesRepository _topCoursesRepository;

  List<int> id = new List();
  List<String> logo = new List();
  List<String> name = new List();
  List<String> author = new List();
  List<String> rating = new List();
  List<String> count = new List();
  List<String> price = new List();

  int page = 1;
  int i;
  bool streamCheck = false;
  bool isLoading = false;
  bool inc;

  Future _loadData() async {

    inc==true?page=page+1:inc = false;
    inc==true?_topCoursesFuture =  _topCoursesRepository.TopCoursesRepositoryFunction(page):null;
    _topCoursesFuture.whenComplete(() =>
        setState(() {
          isLoading = false;
          inc = false;
          streamCheck = true;
         }
        ));
    // await new Future.delayed(new Duration(seconds: 2));
    // setState(() {
    //   streamCheck = true;
    //   isLoading = false;
    //   inc = false;
    // });
  }

  @override
  void initState() {
    int pageno1 = 1;
    _topCoursesRepository = TopCoursesRepository();
    _topCoursesFuture = _topCoursesRepository.TopCoursesRepositoryFunction(pageno1);
    setState(() {
      streamCheck = true;
    });
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
              icon: Icon(Icons.arrow_back_rounded,
                  color: Colors.black, size: w * 0.065),
              onPressed: () {
                Navigator.pop(context);
              }),
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.only(top: h * 0.009),
            child: Image.asset(
              'images/logo.png',
              fit: BoxFit.contain,
              height: h * 0.045,
            ),
          ),
        ),
      ),
      body: NotificationListener<OverscrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            if(inc==true){
              _loadData();
            }
            setState(() {
              inc==true?isLoading = true:isLoading=false;
            });
          }
        },
        child: ListView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: [
            FutureBuilder<TopCoursesModel>(
                future: _topCoursesFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.courses != null) {
                      if(streamCheck)
                      {
                        print('stream builder hit');
                        for(i=0;i<snapshot.data.courses.data.length;i++)
                        {
                          id.add(snapshot.data.courses.data[i].id);
                          logo.add(snapshot.data.courses.data[i].courseLogo);
                          name.add(snapshot.data.courses.data[i].courseName);
                          author.add(snapshot.data.courses.data[i].author);
                          rating.add(snapshot.data.courses.data[i].rating);
                          count.add(snapshot.data.courses.data[i].rating);
                          price.add(snapshot.data.courses.data[i].coursePrice);
                        }
                        Future.delayed(Duration.zero, () {
                          setState(() {
                            snapshot.data.courses.nextPageUrl!=null?inc=true:inc=false;
                            streamCheck = false;
                          });
                        });
                      }
                      return ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: h * 0.02, left: w * 0.035,bottom: h*0.02),
                            child: Text(
                              'Top courses',
                              style: TextStyle(fontSize: w*0.05, fontWeight: FontWeight.w500),
                            ),
                          ),
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.only(left: w*0.01,right: w*0.01,),
                            itemCount: name.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CoursePreview(id[index].toString())),);
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
                                            image: NetworkImage("$imageURL${logo[index]}"),
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
                                                    name[index],
                                                    style: TextStyle(fontSize: w*0.038, fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: w*0.04),
                                                  child: Text(
                                                    '\$ ${price[index]}',
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
                                                      author[index],
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
                                                      rating: double.parse(rating[index]),
                                                      itemBuilder: (context, index) => Icon(
                                                        Icons.star,
                                                        color: Color.fromRGBO(249, 160, 27, 1),
                                                      ),
                                                      itemCount: 5,
                                                      itemSize: 16.0,
                                                      direction: Axis.horizontal,
                                                    ),
                                                    Text('${rating[index]} (${count[index]})',
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
                          isLoading?
                          Container(
                            height: 70.0,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 3.0,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color.fromRGBO(156, 175, 23, 1),
                                ),
                              ),
                            ),
                          ):Container(
                            height: 70.0,
                          )
                        ],
                      );
                    } else {
                      return Center(child: Text("No data"));
                    }
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(child: Text("error"));
                  } else {
                    return Container(
                      height: h*0.8,
                      child: Center(child: CircularProgressIndicator(
                        strokeWidth: 3.0,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(156, 175, 23, 1),
                        ),
                      ),),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
