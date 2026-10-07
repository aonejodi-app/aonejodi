// import 'dart:convert';
//
// import 'package:app/models/combined-user-model.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// class AdvantageSearchUserController extends GetxController {
//   static const String baseUrl = 'https://superjodi.in/API/index.php?p=';
//
//   List<CombinedUser> advsearchedUserList = [];
//   var isLoading = false.obs;
//
//   Future<void> advsearchUser(
//     String gender,
//     String religion,
//     String motherTongue,
//     String maritalStatus,
//     String country,
//     String minAge,
//     String maxAge,
//     String caste,
//     String state,
//     String city,
//   ) async {
//     final uri = Uri.parse('${baseUrl}onAdvancedSearchMatch');
//     final body = jsonEncode({
//       'gender': gender,
//       'religion': religion,
//       'mothertongue': motherTongue,
//       'marital_status': maritalStatus,
//       'country': country,
//       'min_age': minAge,
//       'max_age': maxAge,
//       'caste': caste,
//       'state': state,
//       'city': city,
//     });
//     print("onAdvancedSearchMatch "+body.toString());
//
//     advsearchedUserList.clear();
//     try {
//       isLoading(true);
//       final response = await http.post(
//         uri,
//         body: body,
//         headers: {'Content-Type': 'application/json'},
//       );
//
//       if (response.statusCode == 200) {
//         final responseBody = jsonDecode(response.body);
//         if (responseBody['code'] == '200') {
//           advsearchedUserList.clear();
//
//           for (var userJson in responseBody['msg']) {
//             CombinedUser user = CombinedUser.fromJson(userJson);
//             print(user.toJson());
//             advsearchedUserList.add(user);
//           }
//
//           print('Users successfully loaded');
//           print(advsearchedUserList[0].toJson());
//         } else {
//           Get.snackbar('Error', 'No users found');
//         }
//       } else {
//         print('Failed to fetch users');
//       }
//     } catch (e) {
//       print(e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }
// }
import 'dart:convert';
import 'package:app/controllers/auth-controller.dart';
import 'package:app/models/combined-user-model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdvantageSearchUserController extends GetxController {
  static const String baseUrl = 'https://superjodi.in/API/index.php?p=';

  final AuthController authController = Get.find<AuthController>();

  List<CombinedUser> advsearchedUserList = [];
  var isLoading = false.obs;

  Future<void> advsearchUser(
      String religion,
      String motherTongue,
      String maritalStatus,
      String country,
      String minAge,
      String maxAge,
      String caste,
      String state,
      String city,
      ) async {

    /// 🔥 Get current user gender safely
    String currentUserGender =
        authController.currentUser.value.gender?.toLowerCase().trim() ?? "male";

    /// 🔥 Decide opposite gender
    String oppositeGender =
    currentUserGender == "male" ? "Female" : "Male";

    final uri = Uri.parse('${baseUrl}onAdvancedSearchMatch');

    final body = jsonEncode({
      'gender': oppositeGender,   // ✅ Added here
      'religion': religion,
      'mothertongue': motherTongue,
      'marital_status': maritalStatus,
      'country': country,
      'min_age': minAge,
      'max_age': maxAge,
      'caste': caste,
      'state': state,
      'city': city,
    });

    print("onAdvancedSearchMatch " + body.toString());

    advsearchedUserList.clear();

    try {
      isLoading(true);

      final response = await http.post(
        uri,
        body: body,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (responseBody['code'] == '200') {

          for (var userJson in responseBody['msg']) {
            CombinedUser user = CombinedUser.fromJson(userJson);
            advsearchedUserList.add(user);
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
