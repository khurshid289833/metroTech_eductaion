import 'package:flutter/material.dart';
import 'package:metrotech_education/categories/model/categoriesModel.dart';
import 'package:metrotech_education/categories/repository/categoriesRepository.dart';
import 'package:metrotech_education/categories/subtop.dart';
import 'package:metrotech_education/constants.dart';

class Categories extends StatefulWidget {

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  Future<CategoriesModel> _getCategories;
  CategoriesRepository _getCategoriesRepository;

  @override
  void initState() {
    super.initState();
    _getCategoriesRepository = CategoriesRepository();
    _getCategories = _getCategoriesRepository.getCategories();
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
        child: FutureBuilder<CategoriesModel>(
            future: _getCategories,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.data != null) {
                  return ListView(
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: w * 0.04, top: h * 0.02,bottom: h*0.005),
                        child: Text(
                          'Top Category',
                          style: TextStyle(fontSize: w*0.045, fontWeight: FontWeight.w500),
                        ),
                      ),
                      GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        padding: EdgeInsets.all(h*0.015),
                        itemCount: snapshot.data.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 15.0,
                          childAspectRatio: 4.7 / 5,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SubTop(
                                          snapshot.data.data[index].id.toString(),
                                          snapshot.data.data[index].subcategory)));
                            },
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Column(
                                children: [
                                  FadeInImage(
                                    placeholder: AssetImage('images/place_holder.png'),
                                    image: NetworkImage("$imageURL${snapshot.data.data[index].categoryLogo}"),
                                    fit: BoxFit.fill,
                                    height: h * 0.18,
                                    width: w,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: h * 0.013, left: w * 0.03, right: w * 0.03),
                                    child: Center(
                                      child: Text(
                                        snapshot.data.data[index].categoryName,
                                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: w*0.035),
                                         softWrap: true,
                                         maxLines: 1,
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
                } else {
                  return Center(child: Text("No data"));
                }
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text("Something went wrong"));
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
       ),
    );
  }
}
