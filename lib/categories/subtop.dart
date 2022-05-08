import 'package:flutter/material.dart';
import 'package:metrotech_education/constants.dart';
import 'package:metrotech_education/course/listOfCourses.dart';

class SubTop extends StatefulWidget {

  final String catid;
  final List data;

  SubTop(this.catid, this.data);

  @override
  _SubTopState createState() => _SubTopState(catid, data);
}

class _SubTopState extends State<SubTop> {

  final String catid;
  final List data;

  _SubTopState(this.catid, this.data);

  @override
  void initState() {
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
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("images/back_pic.png"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: ListView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          children: [
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                padding: EdgeInsets.all(h*0.013),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.035,top: h*0.01),
                        child: Text(
                          data[index].subCategoryName,
                          style: TextStyle(fontSize: w*0.045, fontWeight: FontWeight.w500),
                        ),
                      ),
                      GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        padding: EdgeInsets.all(h*0.013),
                        itemCount: data[index].topic.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 15.0,
                          childAspectRatio: 4.5 / 5,
                        ),
                        itemBuilder: (BuildContext context, int index1) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,MaterialPageRoute(builder: (context) => ListOfCourses(
                                          catid,
                                          data[index].id,
                                          data[index].topic[index1].id)));
                            },
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Column(
                                children: [
                                  FadeInImage(
                                    placeholder: AssetImage('images/place_holder.png'),
                                    image: NetworkImage("$imageURL${data[index].topic[index1].topicLogo}"),
                                    fit: BoxFit.fill,
                                    height: h * 0.17,
                                    width: w,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: h * 0.013,bottom: h*0.01),
                                    child: Center(
                                      child: Text(
                                        data[index].topic[index1].topicName,
                                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: w*0.035),
                                      ),
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
                }),
          ],
        ),
      ),
    );
  }
}
