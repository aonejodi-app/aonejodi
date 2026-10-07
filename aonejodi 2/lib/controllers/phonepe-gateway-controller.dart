import 'dart:convert';

import 'package:app/models/combined-user-model.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as custom_tabs;
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class PhonepeController extends GetxController {
  static const String baseUrl = 'https://superjodi.in/API/index.php?p=';

  List<CombinedUser> searchedUserList = [];
  var isLoading = false.obs;

  // Future<void> onStandard(BuildContext context, String amount, String coins) async {
  //   try {
  //     // Step 1: Prepare request data
  //     int finalAmount = int.parse(amount) * 100;
  //     String merchantTransactionId = DateTime.now().millisecondsSinceEpoch.toString();
  //     final prefs = await SharedPreferences.getInstance();
  //     String? userUid = prefs.getString('user_uid');
  //
  //     if (userUid != null) {
  //       print("User UID: $userUid");
  //     } else {
  //       print("No UID found.");
  //     }
  //
  //     Map<String, dynamic> paymentInstrument = {
  //       "type": "PAY_PAGE",
  //     };
  //
  //     Map<String, dynamic> requestData = {
  //       "merchantId": Variables.merchantId,
  //       "merchantTransactionId": merchantTransactionId,
  //       "merchantUserId": userUid,
  //       "amount": finalAmount,
  //       "redirectUrl": Variables.redirectUrl,
  //       "redirectMode": "REDIRECT",
  //       "callbackUrl": Variables.callbackUrl,
  //       "mobileNumber": Variables.userPhone,
  //       "paymentInstrument": paymentInstrument,
  //     };
  //
  //     // Step 2: Encode and create hash
  //     String jsonString = jsonEncode(requestData);
  //     String base64Data = base64Encode(utf8.encode(jsonString));
  //     String secret = Variables.secretKey;
  //     String payload = "$base64Data/pg/v1/pay$secret";
  //     String sha256Hash = sha256.convert(utf8.encode(payload)).toString() + "###1";
  //
  //     // Step 3: Send to server to initiate transaction
  //     Map<String, dynamic> parameters = {
  //       "request_data": base64Data,
  //       "sha": sha256Hash,
  //       "merchantTransactionId": merchantTransactionId,
  //       "mobileNumber": userUid,
  //       "amount": amount,
  //       "coins": coins,
  //     };
  //
  //
  //     final response = await http.post(
  //       Uri.parse(Variables.onUPIPayment),
  //       body: jsonEncode(parameters), // ✅ convert Map to JSON string
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //     );
  //     print("parametersphonepe"+jsonEncode(parameters));
  //
  //    // String code = outerJson["code"]; // ✅ FIXED HERE
  //
  //     if (response.statusCode == 200) {
  //       final outerJson = jsonDecode(response.body);
  //       print("parametersphonepe" + jsonEncode(outerJson));
  //
  //       String msgString = outerJson["msg"];
  //       final msgJson = jsonDecode(msgString);
  //       String code = outerJson["code"];
  //       if (code == "200") {
  //         final redirectUrl = msgJson["data"]["instrumentResponse"]["redirectInfo"]["url"];
  //
  //         try {
  //           await custom_tabs.launchUrl(
  //             redirectUrl,
  //             customTabsOptions: const CustomTabsOptions(
  //               urlBarHidingEnabled: true,
  //               showTitle: true,
  //               instantAppsEnabled: true,
  //               shareState: CustomTabsShareState.off,
  //             ),
  //           );
  //         } catch (e) {
  //           debugPrint('Custom Tab failed: $e');
  //
  //           // Fallback
  //           try {
  //             await url_launcher.launchUrl(Uri.parse(redirectUrl));
  //           } catch (liteErr) {
  //             debugPrint("Fallback also failed: $liteErr");
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               const SnackBar(content: Text('Could not open payment page.')),
  //             );
  //           }
  //         }
  //       } else {
  //         debugPrint("Payment response code != 200");
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Payment failed. Please try again.')),
  //         );
  //       }
  //     }
  //
  //   } catch (e) {
  //     print("Error during UPI payment: $e");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Something went wrong during payment. $e")),
  //     );
  //   }
  // }

  Future<void> onStandard(BuildContext context, String amount, String coins) async {
    try {
      // Step 1: Prepare request data
      int finalAmount = int.parse(amount) * 100;
      String merchantTransactionId = DateTime.now().millisecondsSinceEpoch.toString();
      final prefs = await SharedPreferences.getInstance();
      String? userUid = prefs.getString('user_uid');

      if (userUid != null) {
        print("User UID: $userUid");
      } else {
        print("No UID found.");
      }

      Map<String, dynamic> paymentInstrument = {
        "type": "PAY_PAGE",
      };

      Map<String, dynamic> requestData = {
        "merchantId": Variables.merchantId,
        "merchantTransactionId": merchantTransactionId,
        "merchantUserId": userUid,
        "amount": finalAmount,
        "redirectUrl": Variables.redirectUrl,
        "redirectMode": "REDIRECT",
        "callbackUrl": Variables.callbackUrl,
        "mobileNumber": Variables.userPhone,
        "paymentInstrument": paymentInstrument,
      };

      // Step 2: Encode and create hash
      String jsonString = jsonEncode(requestData);
      String base64Data = base64Encode(utf8.encode(jsonString));
      String secret = Variables.secretKey;
      String payload = "$base64Data/pg/v1/pay$secret";
      String sha256Hash = sha256.convert(utf8.encode(payload)).toString() + "###1";

      // Step 3: Send to server to initiate transaction
      Map<String, dynamic> parameters = {
        "request_data": base64Data,
        "sha": sha256Hash,
        "merchantTransactionId": merchantTransactionId,
        "mobileNumber": userUid,
        "amount": amount,
        "coins": coins,
      };


      final response = await http.post(
        Uri.parse(Variables.onUPIPayment),
        body: jsonEncode(parameters), // ✅ convert Map to JSON string
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print("parametersphonepe"+jsonEncode(parameters));

      // String code = outerJson["code"]; // ✅ FIXED HERE

      if (response.statusCode == 200) {
        final outerJson = jsonDecode(response.body);
        print("parametersphonepe" + jsonEncode(outerJson));

        String msgString = outerJson["msg"];
        final msgJson = jsonDecode(msgString);
        String code = outerJson["code"];
        if (code == "200") {
          final redirectUrl = msgJson["data"]["instrumentResponse"]["redirectInfo"]["url"];

          try {
            await custom_tabs.launchUrl(
              redirectUrl,
              customTabsOptions: const CustomTabsOptions(
                urlBarHidingEnabled: true,
                showTitle: true,
                instantAppsEnabled: true,
                shareState: CustomTabsShareState.off,
              ),
            );
          } catch (e) {
            debugPrint('Custom Tab failed: $e');

            // Fallback
            try {
              await url_launcher.launchUrl(Uri.parse(redirectUrl));
            } catch (liteErr) {
              debugPrint("Fallback also failed: $liteErr");
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Could not open payment page.')),
              );
            }
          }
        } else {
          debugPrint("Payment response code != 200");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Payment failed. Please try again.')),
          );
        }
      }

    } catch (e) {
      print("Error during UPI payment: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong during payment. $e")),
      );
    }
  }

}

class Variables {

  static const merchantId = "M1QOPWXVV3NP";
  static const secretKey = "36b41600-2a81-436f-8880-d09a97ded813";
  static const redirectUrl = "https://superjodi.in/API/phonepe/back.html";
  static const callbackUrl = "https://superjodi.in/API/phonepe/upi_callbackk.php";
  static const onUPIPayment = "https://superjodi.in/API/phonepe/upi.php";
  static const userId = "123456"; // Fetch from local storage
  static const userPhone = "9876543210"; // Fetch from local storage
}
