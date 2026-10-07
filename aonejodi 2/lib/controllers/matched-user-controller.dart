import 'dart:convert';
import 'package:app/models/combined-user-model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MatchedUserController extends GetxController {
  static const String baseUrl = 'https://superjodi.in/API/index.php?p=';

  RxList<CombinedUser> matchedUsersList =
      <CombinedUser>[].obs; 
  var isLoading = false.obs;

  Future<void> matchedUserFind(
    String gender,
    String country,
    String age,
  ) async {
    final uri = Uri.parse('${baseUrl}getMatchedUsers');
    final body = jsonEncode({
      'gender': gender,
      'country': country,
      'age_between': age,
    });

    try {
      matchedUsersList.clear();
      isLoading(true);
      final response = await http.post(
        uri,
        body: body,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print("responseBody $responseBody");
        if (responseBody['code'] == '200') {
          matchedUsersList.clear();

          for (var userJson in responseBody['msg']) {
            CombinedUser user = CombinedUser.fromJson(userJson);
            matchedUsersList.add(user);
          }
          print('Users successfully loaded');
        } else {
          Get.snackbar('Error', 'No users found');
        }
      } else {
        print('Failed to fetch users');
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
  Future<void> shortlistedUserFind(String user_id) async {
    final uri = Uri.parse('${baseUrl}getShortlistedProfiles');
    final body = jsonEncode({'user_id': user_id});

    try {
      matchedUsersList.clear();
      isLoading(true);

      final response = await http.post(
        uri,
        body: body,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print("responseBody $responseBody");

        if (responseBody['code'].toString() == '200') {
          matchedUsersList.clear();

          for (var userJson in responseBody['data']) {
            CombinedUser user = CombinedUser.fromJson(userJson);
            matchedUsersList.add(user);
          }
          print('Users successfully loaded: ${matchedUsersList.length}');
        } else {
          Get.snackbar('Error', 'No users found');
        }
      } else {
        print('Failed to fetch users. HTTP: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading(false);
    }
  }

}
