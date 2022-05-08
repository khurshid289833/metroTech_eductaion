import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class ViewCourseContent extends StatefulWidget {
  String name;
  String desc;
  String content;

  ViewCourseContent(this.name, this.desc, this.content);

  @override
  _ViewCourseContentState createState() =>
      _ViewCourseContentState(name, desc, content);
}

class _ViewCourseContentState extends State<ViewCourseContent> {
  String name;
  String desc;
  String content;

  _ViewCourseContentState(this.name, this.desc, this.content);

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
        color: Color.fromRGBO(249, 249, 249, 1),
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("images/back_pic.png"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: w * 0.04, top: h * 0.01, right: w * 0.04),
              child: Text(
                name,
                style: TextStyle(fontSize: w * 0.045, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: w * 0.04, top: h * 0.008, right: w * 0.04),
              child: Text(
                desc,
                style: TextStyle(
                  fontSize: w * 0.04,
                  color: Color.fromRGBO(130, 130, 130, 1),
                  //decoration: TextDecoration.underline,
                  //decorationColor: Color.fromRGBO(130, 130, 130, 1),
                  //decorationThickness: 1,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: w * 0.025, top: h * 0.005, right: w * 0.025),
              child: Html(data: content, style: {
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
      ),
    );
  }
}
