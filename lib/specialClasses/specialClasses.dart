import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metrotech_education/main.dart';
import 'package:metrotech_education/signin/signin.dart';
import 'package:metrotech_education/signup/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:metrotech_education/specialClasses/model/specialClassesModel.dart';
import 'package:metrotech_education/specialClasses/repository/specialClassesRepository.dart';
import 'package:url_launcher/url_launcher.dart';

class SpecialClasses extends StatefulWidget {
  @override
  _SpecialClassesState createState() => _SpecialClassesState();
}

class _SpecialClassesState extends State<SpecialClasses> {

  Future<SpecialClassesModel> _specialClassesFuture;
  SpecialClassesRepository _specialClassesRepository;
  SharedPreferences prefs;
  String token="";

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString("access_token");
    _specialClassesRepository = SpecialClassesRepository();
    _specialClassesFuture = _specialClassesRepository.SpecialClassesRepositoryFunction(token);
    setState(() {});
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  void initState() {
    createSharedPref();
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
              icon:
              Icon(Icons.arrow_back_rounded, color: Colors.black, size: 25),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
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
        FutureBuilder<SpecialClassesModel>(
          future: _specialClassesFuture,
          builder: (context, snapshot){
            if(snapshot.hasData){
              if(snapshot.data.data!=null){

                DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(snapshot.data.data[0].course[0].meetings[0].startTime);
                var inputDate = DateTime.parse(parseDate.toString());
                var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
                var outputDate = outputFormat.format(inputDate);
                
                return ListView(
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.data.length,
                      itemBuilder: (context,index1){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: h*0.02,left: w*0.04,right: w*0.04,bottom: h*0.03),
                              child: Text(snapshot.data.data[index1].privateClassName,
                                style: TextStyle(fontSize: w*0.045, fontWeight: FontWeight.w500),
                              ),
                            ),
                            snapshot.data.data[index1].course.isNotEmpty?
                            Container(
                              height: h*0.36,
                              margin: EdgeInsets.only(left: w*0.04,right: w*0.02),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black26),
                              ),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data.data[index1].course.length,
                                itemBuilder: (context,index2){
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: w*0.8,
                                        height: h*0.1,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                          color: Color.fromRGBO(236, 236, 236, 1),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: w*0.05,right: w*0.03,top: h*0.023),
                                              child: Text(snapshot.data.data[index1].course[index2].courseName,
                                                style: TextStyle(fontSize: w*0.04,fontWeight: FontWeight.w500,color: Color.fromRGBO(88, 88, 88, 1)),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(left: w*0.05,right: w*0.02,top: h*0.01),
                                                  child: Text('Created by',
                                                    style: TextStyle(color: Color.fromRGBO(114, 114, 114, 1),fontSize: w*0.038),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(right: w*0.03,top: h*0.01),
                                                  child: Text(snapshot.data.data[index1].course[index2].authorName,
                                                    style: TextStyle(fontWeight: FontWeight.w500,fontSize: w*0.04,color: Color.fromRGBO(88, 88, 88, 0.8)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: w*0.8,
                                        height: h*0.001,
                                        color: Colors.black26,
                                      ),
                                      Container(
                                        width: w*0.8,
                                        child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          physics: ScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.data[index1].course[index2].meetings.length,
                                          itemBuilder: (context,index3){
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(left: w*0.05,right: w*0.02,top: h*0.02),
                                                          child: Text('Meeting ID',
                                                            style: TextStyle(fontSize: w*0.038,color:Color.fromRGBO(114, 114, 114, 1)),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: w*0.05,right: w*0.04,top: h*0.01),
                                                          child: Text(snapshot.data.data[index1].course[index2].meetings[index3].meetingId,
                                                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: w*0.04,color: Color.fromRGBO(88, 88, 88, 0.8)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      height: h * 0.05,
                                                      width: w*0.25,
                                                      margin: EdgeInsets.only(right: w * 0.04,top: h*0.015),
                                                      decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                            colors: [
                                                              Color.fromRGBO(84, 201, 165, 1),
                                                              Color.fromRGBO(156, 175, 23, 1)
                                                            ],
                                                          ),
                                                          borderRadius: BorderRadius.all(Radius.circular(25))),
                                                      child: InkWell(
                                                        onTap: () {
                                                          _launchInBrowser(snapshot.data.data[index1].course[index2].meetings[index3].joinUrl);
                                                        },
                                                        child: Center(child: Text('Join',
                                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: w*0.045),
                                                        )),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(left: w*0.05,right: w*0.02,top: h*0.02),
                                                          child: Text('Duration',
                                                            style: TextStyle(fontSize: w*0.038,color:Color.fromRGBO(114, 114, 114, 1)),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: w*0.05,right: w*0.02,top: h*0.01),
                                                          child: Text(snapshot.data.data[index1].course[index2].meetings[index3].duration,
                                                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: w*0.04,color: Color.fromRGBO(88, 88, 88, 0.8)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(left: w*0.1,right: w*0.02,top: h*0.02),
                                                          child: Text('Topic',
                                                            style: TextStyle(fontSize: w*0.038,color:Color.fromRGBO(114, 114, 114, 1)),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: w*0.1,right: w*0.02,top: h*0.01),
                                                          child: Text(snapshot.data.data[index1].course[index2].meetings[index3].topic,
                                                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: w*0.04,color: Color.fromRGBO(88, 88, 88, 0.8)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(left: w*0.1,right: w*0.04,top: h*0.02),
                                                          child: Text('Agenda',
                                                            style: TextStyle(fontSize: w*0.038,color:Color.fromRGBO(114, 114, 114, 1)),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: w*0.1,right: w*0.04,top: h*0.01),
                                                          child: Text(snapshot.data.data[index1].course[index2].meetings[index3].agenda,
                                                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: w*0.04,color: Color.fromRGBO(88, 88, 88, 0.8)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(left: w*0.05,right: w*0.02,top: h*0.02),
                                                      child: Text('Start Time',
                                                        style: TextStyle(fontSize: w*0.038,color:Color.fromRGBO(114, 114, 114, 1)),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: w*0.05,right: w*0.04,top: h*0.01),
                                                      child: Text(outputDate,
                                                        style: TextStyle(fontWeight: FontWeight.w500,fontSize: w*0.04,color: Color.fromRGBO(88, 88, 88, 0.8)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),

                                    ],
                                  );
                                },
                              ),
                            )
                                :Container(
                                margin: EdgeInsets.only(left: w*0.04,right: w*0.04),
                                child: Text('You have not scheduled any classes in this section.',
                                  style: TextStyle(fontSize: w*0.045,color: Color.fromRGBO(88, 88, 88, 0.8)),
                                ))
                          ],
                        );
                      },
                    ),
                  ],
                );
              }else{
                return Center(child: Text("No data"));
              }
            }else if (snapshot.hasError) {
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
          }
      )
          :Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/back_pic.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
            children:[
              Container(
                margin: EdgeInsets.only(top: h*0.06),
                child: Center(child: Text('Oops! You are logged out',
                  style: TextStyle(fontSize: w*0.038,color: Color.fromRGBO(108, 108, 108, 1)),
                )),
              ),
              Container(
                margin: EdgeInsets.only(top: h*0.05),
                child: Image.asset("images/sad_logout.png",height: h*0.12,),
              ),
              Container(
                margin: EdgeInsets.only(top: h*0.07),
                child: Center(
                  child: Text('Please login first to see your Special Classes.',
                    style: TextStyle(fontSize: w*0.036,fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                height: h*0.05,
                margin: EdgeInsets.only(left: w * 0.3, right: w * 0.3, top: h * 0.04),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Signin()),);
                  },
                  child: Center(
                    child: Text(
                      'Login Now',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: w*0.045),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: w * 0.32, right: w * 0.3,top: h*0.02),
                child: Row(
                  children: [
                    Text(
                      'New here? ',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: w * 0.037,
                          fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup())),
                      },
                      child: Text(
                        'REGISTER',
                        style: TextStyle(
                            color: Color.fromRGBO(77, 200, 174, 1),
                            fontSize: w * 0.035,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ]
        ),
      )
    );
  }
}
