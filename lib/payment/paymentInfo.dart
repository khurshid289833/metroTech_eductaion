import 'package:flutter/material.dart';
import 'package:metrotech_education/dashboard/dashboard.dart';
import 'package:metrotech_education/myCourse/myCourse.dart';

class PaymentInfo extends StatefulWidget {
  @override
  _PaymentInfoState createState() => _PaymentInfoState();
}

class _PaymentInfoState extends State<PaymentInfo> {
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/back_pic.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: h*0.08),
              child: Image.asset("images/payment_icon.png",height: h*0.08,),
            ),
            Container(
                margin: EdgeInsets.only(top: h*0.03),
                child: Center(child: Text('Thank you!',
                    style: TextStyle(fontSize: w*0.04
                        ,color: Color.fromRGBO(108, 108, 108, 1),fontWeight: FontWeight.w500)),
                )),
            Container(
              margin: EdgeInsets.only(top: h*0.025),
              child: Center(child: Text('Your payment has been processed',
                style: TextStyle(fontSize: w*0.05,color: Color.fromRGBO(108, 108, 108, 1),fontWeight: FontWeight.w500),
              )),
            ),
            Container(
              child: Center(child: Text('successfully.',
                style: TextStyle(fontSize: w*0.05,color: Color.fromRGBO(108, 108, 108, 1),fontWeight: FontWeight.w500),
              )),
            ),

            Container(
              height: h*0.05,
              margin: EdgeInsets.only(left: w * 0.27, right: w * 0.27, top: h * 0.09),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyCourse()),);
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
