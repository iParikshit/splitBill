import 'dart:convert';

import 'package:contacts_service/contacts_service.dart';
import 'package:http/http.dart';
import 'package:splitbill/models/bill.dart';
import 'package:splitbill/util/constants.dart';

class ApiProvider {
  var client = Client();

  var baseUrl = "https://splitbill-49e59-default-rtdb.firebaseio.com";

  getBill({String phone}) async {
    if (phone.length == 10) {
      phone = "+91" + phone;
    }

    var response =
        await client.get(Uri.parse("${baseUrl}/bills/${phone}.json"));
    if (response.statusCode == 200) {
      return Bill.fromJson(jsonDecode(response.body));
    }
  }

  saveFCMToken({String token, String phone}) async {
    if (phone.length == 10) {
      phone = "+91" + phone;
    }
    print("${baseUrl}/FCM/${phone}.json");
    var response = await client.put(Uri.parse("${baseUrl}/FCM/${phone}.json"),
        body: jsonEncode(token));
    print(response.statusCode);
    print(response.body);
  }

  sendNotification({List<Contact> contacts}) async {
    contacts.forEach((contact) {
      if (contact.phones.length != 0) {
        _sendNotificationToSinglePhone(
            phone: contact.phones.first.value
                .replaceAll(new RegExp(r'[^0-9]'), ''));
      }
    });
  }

  _sendNotificationToSinglePhone({String phone}) async {
    if (phone.length == 10) {
      phone = "+91" + phone;
    }
    var response = await client.get(Uri.parse("${baseUrl}/FCM/${phone}.json"));
    print("${baseUrl}/FCM/${phone}.json");
    if (response.statusCode == 200) {
      print(response.body);
      if (response.body != "null") {
        var fcm_url = "https://fcm.googleapis.com/fcm/send";
        var fcm_res = await client.post(
          Uri.parse(fcm_url),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "key=${kFCMKey}"
          },
          body: jsonEncode(
            {
              "notification": {
                "title": "New Bill",
                "body": "A new bill has been shared with you"
              },
              "to": response.body.replaceAll("\"", "").toString()
            },
          ),
        );
        print(fcm_res.statusCode);
        print(fcm_res.body);
      }
    }
  }
}
