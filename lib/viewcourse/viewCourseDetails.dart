import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class ViewCourseDetails extends StatefulWidget {
  String courseDesc;
  ViewCourseDetails(this.courseDesc);
  @override
  _ViewCourseDetailsState createState() => _ViewCourseDetailsState(courseDesc);
}

class _ViewCourseDetailsState extends State<ViewCourseDetails> {
  String courseDesc;
  _ViewCourseDetailsState(this.courseDesc);
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
      body: ListView(
        children: [

          Container(
            margin: EdgeInsets.only(left: w*0.03,right: w*0.03,bottom: h*0.03),
            child: Html(data: courseDesc, style: {
              "h1": Style(fontSize: FontSize.large),
              "h2": Style(fontSize: FontSize.medium),
              "h3": Style(fontSize: FontSize.medium),
              "h4": Style(fontSize: FontSize.medium),
              "h5": Style(fontSize: FontSize.medium),
              "h6": Style(fontSize: FontSize.medium),
            }),
          ),
        ],
      ),
    );
  }
}
