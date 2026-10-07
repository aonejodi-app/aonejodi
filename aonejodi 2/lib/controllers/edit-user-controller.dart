import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../views/screens/home-page.dart';

class EditUserController extends GetxController {
  static const String baseUrl =
      'https://superjodi.in/API/index.php?p=onUpdateUser';
  static const String imageUrl =
      'https://superjodi.in/API/index.php?p=onDeleteImage';

  Future<void> editUser(
      String f_name,
      String birth_time,
      String email,
      String mobile,
      String gender,
      String day,
      String month,
      String year,
      String mothertongue,
      String religion,
      String caste,
      String country,
      String state,
      String city,
      String profilecreator,
      String image,
      String image2,
      String image3,
      String language,
      String physical_status,
      String medical,
      String father,
      String f_occupation,
      String mother,
      String m_occupation,
      String brothers,
      String sisters,
      String height,
      String education,
      String employed,
      String complexion,
      String profession,
      String music,
      String sports,
      String movies,
      String marital_status,
      String outfit,
      String about,
      String annual_income,
      String smoking,
      String drinking,
      String eating,
      String age,
      String family_type,
      String body_type,
      String manglik,
      String family_status,
      String birth_place,
      String password) async {
    final uri = Uri.parse(baseUrl);
    final body = jsonEncode({
      'f_name': f_name,
      'birth_time': birth_time,
      'email': email,
      'mobile': mobile,
      'gender': gender,
      'day': day,
      'month': month,
      'year': year,
      'mothertongue': mothertongue,
      'religion': religion,
      'country': country,
      'city': city,
      'state': state,
      'profilecreator': profilecreator,
      'caste': caste,
      'image': image,
      'image2': image2,
      'image3': image3,
      'language': language,
      'physical_status': physical_status,
      'medical': medical,
      'father': father,
      'f_occupation': f_occupation,
      'mother': mother,
      'm_occupation': m_occupation,
      'brothers': brothers,
      'sisters': sisters,
      'height': height,
      'education': education,
      'employed': employed,
      'complexion': complexion,
      'profession': profession,
      'music': music,
      'sports': sports,
      'movies': movies,
      'marital_status': marital_status,
      'outfit': outfit,
      'about': about,
      'annual_income': annual_income,
      'smoking': smoking,
      'drinking': drinking,
      'eating': eating,
      'age': age,
      'family_type': family_type,
      'body_type': body_type,
      'manglik': manglik,
      'family_status': family_status,
      'birth_place': birth_place,
      'password': password
    });

    print('Request body: $body');

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      final responseBody = jsonDecode(response.body);
      print('Response: this is the bdoyfdoihff $responseBody');

      if (responseBody['code'] == '200') {
        Get.snackbar('User details updated successfully',
            'The user has been updated successfully');
        Get.to(HomePage());
      } else {
        // Handle error
        print('Failed to update user details: ${responseBody['message']}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<bool> deleteImage(String email, String image) async {
    final uri = Uri.parse(imageUrl);
    final body = jsonEncode({
      'email': email,
      "image": image,
    });

    print('Request body: $body');

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      final responseBody = jsonDecode(response.body);
      print('Response: this is the bdoyfdoihff $responseBody');

      if (responseBody['code'] == '200') {
        Get.snackbar('Updated successfully', 'Image deleted successfully');
        return true;
      } else {
        // Handle error
        print('Failed to update user details: ${responseBody['message']}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
    }
    return false;
  }
}
