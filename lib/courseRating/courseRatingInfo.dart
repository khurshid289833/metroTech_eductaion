import 'package:flutter/material.dart';

class CourseRatingInfo extends StatefulWidget {
  @override
  _CourseRatingInfoState createState() => _CourseRatingInfoState();
}

class _CourseRatingInfoState extends State<CourseRatingInfo> {
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/back_pic.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
            children:[
              Container(
                margin: EdgeInsets.only(top: h*0.08),
                child: Image.asset("images/star_rating.png",height: h*0.17,),
              ),
              Container(
                margin: EdgeInsets.only(top: h*0.07),
                child: Center(
                  child: Text('You have already rated this course!',
                    style: TextStyle(fontSize: w*0.035,fontWeight: FontWeight.w500,color: Color.fromRGBO(108, 108, 108, 1)),
                  ),
                ),
              )
            ]
        ),
      )

    );
  }
}
