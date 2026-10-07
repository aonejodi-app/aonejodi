// // import 'dart:convert';
// //
// // import 'package:app/models/combined-user-model.dart';
// // import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;
// //
// // class SearchUserController extends GetxController {
// //   static const String baseUrl = 'https://superjodi.in/API/index.php?p=';
// //
// //   List<CombinedUser> searchedUserList = [];
// //   var isLoading = false.obs;
// //
// //   Future<void> searchUser(
// //     String gender,
// //     String religion,
// //     String motherTongue,
// //     String maritalStatus,
// //     String country,
// //     String minAge,
// //     String maxAge,
// //   ) async {
// //     final uri = Uri.parse('${baseUrl}onSearchMatch');
// //     final body = jsonEncode({
// //       'gender': gender,
// //       'religion': religion,
// //       'mothertongue': motherTongue,
// //       'marital_status': maritalStatus,
// //       'country': country,
// //       'min_age': minAge,
// //       'max_age': maxAge,
// //     });
// //     searchedUserList.clear();
// //
// //     try {
// //       isLoading(true);
// //       final response = await http.post(
// //         uri,
// //         body: body,
// //         headers: {'Content-Type': 'application/json'},
// //       );
// //
// //       if (response.statusCode == 200) {
// //         final responseBody = jsonDecode(response.body);
// //         if (responseBody['code'] == '200') {
// //           searchedUserList.clear();
// //
// //           // for (var userJson in responseBody['msg']) {
// //           //   CombinedUser user = CombinedUser.fromJson(userJson);
// //           //
// //           //   // ✅ Hide same gender
// //           //   if (user.gender != gender) {
// //           //     searchedUserList.add(user);
// //           //   }
// //           // }
// //           for (var userJson in responseBody['msg']) {
// //             CombinedUser user = CombinedUser.fromJson(userJson);
// //
// //             // Normalize both strings to lowercase to ensure a perfect match
// //             if (user.gender.toString().toLowerCase() == gender.toLowerCase()) {
// //               searchedUserList.add(user);
// //             }
// //           }
// //
// //           print('Filtered users loaded');
// //         }
// //         else {
// //           Get.snackbar('Error', 'No users found');
// //         }
// //       } else {
// //         print('Failed to fetch users');
// //       }
// //     } catch (e) {
// //       print(e.toString());
// //     } finally {
// //       isLoading(false);
// //     }
// //   }
// // }
//
//
//
// import 'dart:convert';
// import 'package:app/controllers/auth-controller.dart';
// import 'package:app/models/combined-user-model.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// class SearchUserController extends GetxController {
//   static const String baseUrl = 'https://superjodi.in/API/index.php?p=';
//
//   final AuthController authController = Get.find<AuthController>();
//
//   List<CombinedUser> searchedUserList = [];
//   var isLoading = false.obs;
//
//   Future<void> searchUser(
//       // String gender,
//       String religion,
//       String motherTongue,
//       String maritalStatus,
//       String country,
//       String minAge,
//       String maxAge,
//       ) async {
//
//     /// 🔥 Get Current User Gender
//     String currentUserGender =
//         authController.currentUser.value.gender ?? "Male";
//
//     /// 🔥 Decide Opposite Gender
//     String oppositeGender =
//     currentUserGender.toLowerCase().trim() == "male"
//         ? "Female"
//         : "Male";
//
//     final uri = Uri.parse('${baseUrl}onSearchMatch');
//
//     final body = jsonEncode({
//       'gender': oppositeGender,   // ✅ Automatically opposite gender
//       'religion': religion,
//       'mothertongue': motherTongue,
//       'marital_status': maritalStatus,
//       'country': country,
//       'min_age': minAge,
//       'max_age': maxAge,
//     });
//
//     searchedUserList.clear();
//
//     try {
//       isLoading(true);
//
//       final response = await http.post(
//         uri,
//         body: body,
//         headers: {'Content-Type': 'application/json'},
//       );
//
//       if (response.statusCode == 200) {
//         final responseBody = jsonDecode(response.body);
//
//         if (responseBody['code'] == '200') {
//
//           for (var userJson in responseBody['msg']) {
//             CombinedUser user = CombinedUser.fromJson(userJson);
//             searchedUserList.add(user);
//           }
//
//           print('Filtered users loaded');
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

class SearchUserController extends GetxController {
  static const String baseUrl = 'https://superjodi.in/API/index.php?p=';

  final AuthController authController = Get.find<AuthController>();

  List<CombinedUser> searchedUserList = [];
  var isLoading = false.obs;

  Future<void> searchUser(
      String religion,
      String motherTongue,
      String maritalStatus,
      String country,
      String minAge,
      String maxAge,
      ) async {

    /// Get current user gender safely
    String currentUserGender =
        authController.currentUser.value.gender?.toLowerCase().trim() ?? "male";

    /// Decide opposite gender
    String oppositeGender =
    currentUserGender == "male" ? "Female" : "Male";

    final uri = Uri.parse('${baseUrl}onSearchMatch');

    final body = jsonEncode({
      'gender': oppositeGender,
      'religion': religion,
      'mothertongue': motherTongue,
      'marital_status': maritalStatus,
      'country': country,
      'min_age': minAge,
      'max_age': maxAge,
    });

    searchedUserList.clear();

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
            searchedUserList.add(user);
          }

        } else {
          Get.snackbar('Error', 'No users found');
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
