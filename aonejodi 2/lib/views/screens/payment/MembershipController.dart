import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../models/MembershipPlan.dart';

class MembershipController extends GetxController {

  var isLoading = false.obs;
  var planList = <MembershipPlan>[].obs;
  static const String baseUrl = 'https://superjodi.in/API/index.php?p=';

  Future<void> getAllPlans() async {
    final uri = Uri.parse('${baseUrl}getAllPlans');

    try {
      isLoading(true);
      planList.clear();

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body['code'] == '200') {
          for (var plan in body['msg']) {
            planList.add(MembershipPlan.fromJson(plan));
          }
        } else {
          Get.snackbar('Error', 'No plans found');
        }
      } else {
        Get.snackbar('Error', 'Server error');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    getAllPlans();
    super.onInit();
  }
}
