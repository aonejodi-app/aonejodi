import 'dart:convert';

import 'package:app/models/combined-user-model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ShortProfilelistController extends GetxController {
  static const String baseUrl = 'https://superjodi.in/API/index.php?p=';

  List<CombinedUser> searchedUserList = [];
  var isLoading = false.obs;
  var email_id="",number="";

  Future<void> onShortlisted(
    String user_id,
    String shortilisted_id,
    ) async {
    email_id = "";
    number ="";
    final uri = Uri.parse('${baseUrl}onShortlistProfile');
    final body = jsonEncode({
      'user_id': user_id,
      'shortilisted_id': shortilisted_id,
       });

    try {
      isLoading(true);
      final response = await http.post(
        uri,
        body: body,
        headers: {'Content-Type': 'application/json'},
      );
      print("parametersphonepe"+jsonEncode(body));

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['code'] == '200') {
          print("parametersphonepe"+jsonEncode(responseBody));

          email_id = responseBody['data']?['email'] ?? 'N/A';
           number = responseBody['data']?['mobile'] ?? 'N/A';

          // Fluttertoast.showToast(
          //   msg: "Shortlisted Successfully",
          //   toastLength: Toast.LENGTH_SHORT,
          //   gravity: ToastGravity.BOTTOM,
          //   backgroundColor: Colors.black87,
          //   textColor: Colors.white,
          //   fontSize: 16.0,
          // );
        } else {
          Fluttertoast.showToast(
            msg: responseBody['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Get.snackbar('Error', responseBody['msg']);
        }
      }
 else {
        Get.snackbar('Error', 'Something went wrong');

        print('Failed to fetch users');
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
  Future<void> onCheckShortlisted(
      String user_id,
      String shortilisted_id,
      ) async {
    email_id = "";
    number ="";
    final uri = Uri.parse('${baseUrl}onCheckShortlistProfile');
    final body = jsonEncode({
      'user_id': user_id,
      'shortilisted_id': shortilisted_id,
    });

    try {
      isLoading(true);
      final response = await http.post(
        uri,
        body: body,
        headers: {'Content-Type': 'application/json'},
      );
      print("parametersphonepe"+jsonEncode(body));

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['code'] == '200') {
          print("parametersphonepe"+jsonEncode(responseBody));

          email_id = responseBody['data']?['email'] ?? 'N/A';
          number = responseBody['data']?['mobile'] ?? 'N/A';

          // Fluttertoast.showToast(
          //   msg: "Shortlisted Successfully",
          //   toastLength: Toast.LENGTH_SHORT,
          //   gravity: ToastGravity.BOTTOM,
          //   backgroundColor: Colors.black87,
          //   textColor: Colors.white,
          //   fontSize: 16.0,
          // );
        }
        else {}
      }
      else {
        Get.snackbar('Error', 'Something went wrong');

        print('Failed to fetch users');
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
