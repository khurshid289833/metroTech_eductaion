import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http_auth/http_auth.dart';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:metrotech_education/api_base/api_base_helper.dart';

class PaypalServicesPrivate {

  final String course_id;

  PaypalServicesPrivate(this.course_id){
    createSharedPref();
    _apiBaseHelper = ApiBaseHelper();
  }

  ApiBaseHelper _apiBaseHelper ;
  SharedPreferences prefs;
  String token = "";



  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString("access_token");
  }

  Map _response;

  String domain = "https://api.sandbox.paypal.com"; // for sandbox mode
  //String domain = "https://api.paypal.com"; // for production mode

  // change clientId and secret with your own, provided by paypal
  String clientId = 'ASap6IxRzhB6znOLPo0GsBTyR3Sk1IxTl5fQ4iwUNBtb5uMRr0PxKOptnoBu7LDDKTsFCNOoZGhDDXgI';
  //'AYPrpoNsXvWUB7jzhi3Gp4fdjHkN1I0BE2ykVkMdrKrWhxqPO5mrklKvZd8um83wbEwb3h0IBGz_bpGV';
  String secret = 'EHkvY5849fQqQrtn-eQamSGuCYUfJ4QEOtryXJgEZG7i8UVxSRCE8RFGe8K5QD7ujFVQRE9RxwGca7YY';

  // for getting the access token from Paypal
  Future<String> getAccessToken() async {
    try {
      var client = BasicAuthClient(clientId, secret);
      var response = await client.post(Uri.parse('$domain/v1/oauth2/token?grant_type=client_credentials'));
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        return body["access_token"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // for creating the payment request with Paypal
  Future<Map<String, String>> createPaypalPayment(transactions, accessToken) async {
    try {
      var response = await http.post(Uri.parse("$domain/v1/payments/payment"),
          body: convert.jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        return null;
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  // for executing the payment transaction
  Future<String> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(url,
          body: convert.jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        var _results = body;
        var _list = _results.values.toList();

        print(_list[4]);
        Map _results1 = _list[4];//start
        var _list1 = _results1.values.toList();
        Map _results2 = _list1[2];
        var _list2 = _results2.values.toList();
        Map _results3 = _list2[4];
        var _list3 = _results3.values.toList();//end

        print("///////////////////////////////////////////////////////");
        print(_list[5]);
        //List<Map<String, Object>> mylist = _list[5];
        //List<Map<String, Object>> mylist1 = mylist[0]["related_resources"];
        List<dynamic> mylist = _list[5];
        List<dynamic> mylist1 = mylist[0]["related_resources"];
        Map _result4 = mylist1[0]["sale"];
        List _list4 = _result4.values.toList();
        Map _result5 = mylist[0]["amount"];
        List _list5 = _result5.values.toList();
        Map _result6 = mylist[0]["payee"];
        List _list6 = _result6.values.toList();

        String transaction_id = _list4[0];
        String payer_email_address = _list2[0];
        String payer_given_name = _list2[1];
        String payer_surname = _list2[2];
        String payer_id = _list2[3];
        String shipping_postal_code = _list3[4];
        String shipping_country_code = _list3[5];
        String status = _list1[1];
        String create_time = _list[8];
        String amount = _list5[0];
        String currency_code = _list5[1];
        String merchant_id = _list6[0];
        String payee_email_address = _list6[1];

        print(course_id);
        print(transaction_id);
        print(payer_email_address);
        print(payer_given_name);
        print(payer_surname);
        print(payer_id);
        print(shipping_postal_code);
        print(shipping_country_code);
        print(status);
        print(create_time);
        print(amount);
        print(currency_code);
        print(merchant_id);
        print(payee_email_address);

        Map body1 = {
          "course_id": course_id,
          "transaction_id": transaction_id,
          "payer_id":payer_id,
          "merchant_id":merchant_id,
          "payee_email_address":payee_email_address,
          "payer_given_name": payer_given_name,
          "payer_surname": payer_surname,
          "payer_email_address": payer_email_address,
          "amount": amount,
          "currency_code": currency_code,
          "shipping_postal_code": shipping_postal_code,
          "shipping_country_code": shipping_country_code,
          "create_time": create_time,
          "status": status
        };
        print("/////////////BODY///////////////////");
        print(body1);
        print("/////////////TOKEN///////////////////");
        print(token);
        _response = await _apiBaseHelper.postWithHeader("api/course-enrollment", body1, "Bearer " + token);
        print("Payment Completed");
        print("this is full body");
        log(body.toString());
        return body["id"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
