import 'dart:convert';
import 'package:app/models/combined-user-model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MatchedIdUserController extends GetxController {
  static const String baseUrl = 'https://superjodi.in/API/index.php?p=';

  RxList<CombinedUser> matchedUserListById = <CombinedUser>[].obs;
  var isLoading = false.obs;

  Future<void> matchedUserFind(String userId) async {
    final uri = Uri.parse('${baseUrl}onSearchbyUserId');
    final body = jsonEncode({
      'uid': userId, // Adjust according to the API requirement
    });

    try {
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
          matchedUserListById.clear();

          for (var userJson in responseBody['msg']) {
            CombinedUser user = CombinedUser.fromJson(userJson);
            matchedUserListById.add(user);
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
}
