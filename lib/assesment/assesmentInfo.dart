import 'package:flutter/material.dart';

class AssessmentInfo extends StatefulWidget {
  @override
  _AssessmentInfoState createState() => _AssessmentInfoState();
}

class _AssessmentInfoState extends State<AssessmentInfo> {
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
          children: [
            Padding(
              padding: EdgeInsets.only(top: h*0.05),
              child: Center(child: Text('Thank you for taking the assessment',
                style: TextStyle(fontSize: w*0.042,color: Color.fromRGBO(150, 151, 152, 0.7)),
              )),
            ),
            Padding(
              padding: EdgeInsets.only(top: h*0.018),
              child: Center(child: Text('Your responses has been saved',
                style: TextStyle(fontSize: w*0.042,fontWeight:FontWeight.w500,color: Color.fromRGBO(140, 140, 140, 1)),
              )),
            ),
            Container(
              margin: EdgeInsets.only(top: h*0.05),
              child: Image.asset("images/book_icon.png",height: h*0.18,),
            ),
            Container(
              height: h*0.055,
              margin: EdgeInsets.only(left: w * 0.25, right: w * 0.25, top: h * 0.06),
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
                  Navigator.pop(context,true);
                },
                child: Center(
                  child: Text(
                    'Go to your course',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: w*0.045),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
