import 'dart:core';
import 'package:flutter/material.dart';
import 'package:metrotech_education/payment/paymentInfo.dart';
import 'package:metrotech_education/payment/paypalServices.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaypalPayment extends StatefulWidget {
  String course_id;
  String course_name;
  String course_price;
  //final Function onFinish;

  PaypalPayment(this.course_id,this.course_name,this.course_price);

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState(course_id,course_name,course_price);
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  String course_id;
  String course_name;
  String course_price;
  PaypalPaymentState(this.course_id,this.course_name,this.course_price);

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String checkoutUrl;
  String executeUrl;
  String accessToken;

  PaypalServices services;

  // you can change default currency according to your need
  Map<dynamic,dynamic> defaultCurrency = {"symbol": "USD ", "decimalDigits": 2, "symbolBeforeTheNumber": true, "currency": "USD"};

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL= 'cancel.example.com';


  @override
  void initState() {
    super.initState();
    services = PaypalServices(course_id);

    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();

        final transactions = getOrderParams();
        final res =
        await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
          });
        }
      } catch (e) {
        print('exception: '+e.toString());
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    });
  }

  // item name, price and quantity
  //String itemName = 'iphone x';
  //String itemPrice = '100.99';
  int quantity = 1;

  Map<String, dynamic> getOrderParams() {
    List items = [
      {
        "name": course_name,
        "quantity": quantity,
        "price": course_price,
        "currency": defaultCurrency["currency"]
      }
    ];


    // checkout invoice details
    String totalAmount = course_price;
    String subTotalAmount = course_price;
    String shippingCost = '0';
    int shippingDiscountCost = 0;
    String userFirstName = 'Gulshan';
    String userLastName = 'Yadav';
    String addressCity = 'Delhi';
    String addressStreet = 'Mathura Road';
    String addressZipCode = '110014';
    String addressCountry = 'India';
    String addressState = 'Delhi';
    String addressPhoneNumber = '+919990119091';

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": subTotalAmount,
              "shipping": shippingCost,
              "shipping_discount":
              ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
            if (isEnableShipping &&
                isEnableAddress)
              "shipping_address": {
                "recipient_name": userFirstName +
                    " " +
                    userLastName,
                "line1": addressStreet,
                "line2": "",
                "city": addressCity,
                "country_code": addressCountry,
                "postal_code": addressZipCode,
                "phone": addressPhoneNumber,
                "state": addressState
              },
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {
        "return_url": returnURL,
        "cancel_url": cancelURL
      }
    };
    return temp;
  }
  bool _check=false;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    print(checkoutUrl);
    if (checkoutUrl != null) {
      return Scaffold(
        appBar:  PreferredSize(
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
        body: Column(
          children: [
            _check==false?Expanded(
              child: Center(child: CircularProgressIndicator(

                strokeWidth: 3.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(156, 175, 23, 1),
                ),
              )),
            ):Container(),
            Expanded(
              child: WebView(
                initialUrl: checkoutUrl,
                javascriptMode: JavascriptMode.unrestricted,
                onPageStarted: (start) {
                  setState(() {
                    _check=true;
                  });
                },
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.contains(returnURL)) {
                    final uri = Uri.parse(request.url);
                    final payerID = uri.queryParameters['PayerID'];
                    if (payerID != null) {
                      services.executePayment(executeUrl, payerID, accessToken).then((id) {
                        //widget.onFinish(id);
                        Navigator.of(context).pop();
                      });
                    } else {
                      Navigator.of(context).pop();
                    }
                    Navigator.of(context).pop();
                    Navigator.push(context,MaterialPageRoute(builder: (context) => PaymentInfo()),);
                  }
                  if (request.url.contains(cancelURL)) {
                    Navigator.of(context).pop();
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PaymentInfo()));
                  }
                  return NavigationDecision.navigate;
                },
              ),
            ),
          ],
        )
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar:  PreferredSize(
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
        body: Center(child: Container(child: CircularProgressIndicator(
          strokeWidth: 3.0,
          valueColor: AlwaysStoppedAnimation<Color>(
            Color.fromRGBO(156, 175, 23, 1),
          ),
        ),)),
      );
    }
  }
}