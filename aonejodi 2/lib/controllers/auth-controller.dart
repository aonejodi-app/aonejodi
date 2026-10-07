import 'dart:convert';
import 'package:app/models/combined-user-model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/views/screens/auth_screens/login-page.dart';
import 'package:app/views/screens/home-page.dart';

class AuthController extends GetxController {
  static const String baseUrl = 'https://superjodi.in/API/index.php?p=';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var isLoading = false.obs;
  Rx<CombinedUser> currentUser = CombinedUser(
      email: '',
      fullName: '',
      gender: '',
      day: '',
      month: '',
      year: '',
      motherTongue: '',
      religion: '',
      caste: '',
      country: '',
      state: '',
      city: '',
      profileCreatedBy: '',
      phoneNumber: '',
      phoneIs: '',
      image: '',
      language: '',
      birthTime: '',
      physicalStatus: '',
      medical: '',
      father: '',
      fathersOccupation: '',
      mother: '',
      mothersOccupation: '',
      brothers: '',
      sisters: '',
      height: '',
      education: '',
      employed: '',
      complexion: '',
      profession: '',
      music: '',
      sports: '',
      movies: '',
      maritalStatus: '',
      outfit: '',
      about: '',
      annualIncome: '',
      smoking: '',
      status: '',
      drinking: '',
      eating: '',
      age: '',
      manglik: '',
      familyType: '',
      familyStatus: '',
      ageBetween: '',
      image2: '',
      image3: '',
      bodyType: '',
      uid: '',
      password: "",
      birthPlace: '')
      .obs;

  // --- UPDATED FLOW: PAYMENT FIRST -> DB SIGNUP LATER ---
  Future<void> registerUser(CombinedUser user) async {
    double fee = 150.0;
    bool isPaymentEnabled = true;

    isLoading(true);

    // 1. Check Admin Payment Settings
    try {
      final feeRes = await http.get(Uri.parse('https://superjodi.in/new_admin/get_app_settings.php'));
      if (feeRes.statusCode == 200) {
        final feeData = jsonDecode(feeRes.body);
        fee = double.tryParse(feeData['registration_fee'].toString()) ?? 150.0;
        isPaymentEnabled = (feeData['is_payment_enabled'].toString() == '1');
      }
    } catch (e) {
      print("Fee Fetch Error: $e");
    } finally {
      isLoading(false);
    }

    // 2. Agar Payment Switch OFF hai -> Directly Save User in DB
    if (!isPaymentEnabled) {
      await _completeSignUp(user, paymentId: 'FREE_REGISTRATION');
      return;
    }

    // 3. Agar Payment Switch ON hai -> Razorpay Open Karein
    Razorpay razorpay = Razorpay();

    var options = {
      'key': 'rzp_live_RFtf0ACqnBV8Rn',
      'amount': (fee * 100).toInt(), // Amount in paise
      'name': 'AoneJodi',
      'description': 'Registration Fee',
      'prefill': {
        'email': user.email ?? '',
        'contact': user.phoneNumber ?? '',
      }
    };

    // Payment Success -> Tabhi DB mein user banega
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse response) async {
      razorpay.clear();
      await _completeSignUp(user, paymentId: response.paymentId ?? '');
    });

    // Payment Cancel/Fail -> DB mein koi entry nahi banegi
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse response) {
      razorpay.clear();
      Get.snackbar('Payment Cancelled', 'Payment is required to complete the registration.');
    });

    razorpay.open(options);
  }

  // Helper Function: Registration Complete Karein Aur DB update Karein
  Future<void> _completeSignUp(CombinedUser user, {required String paymentId}) async {
    final uri = Uri.parse('${baseUrl}onSignUp');
    final body = user.toJson();

    try {
      isLoading(true);
      final response = await http.post(uri, body: jsonEncode(body));

      if (response.statusCode == 200) {
        final resData = jsonDecode(response.body);

        if (resData['code'] == '200') {
          // Fetch User Details to get UID
          final userDetails = await getUserDetails(user.email ?? "");

          if (userDetails['status'] == '200') {
            final data = userDetails['data'] as List<dynamic>;

            if (data.isNotEmpty) {
              data.sort((a, b) => int.parse(b['uid']).compareTo(int.parse(a['uid'])));
              currentUser.value = CombinedUser.fromJson(data[0]);

              // Update DB with Payment ID
              if (currentUser.value.uid != null && currentUser.value.uid!.isNotEmpty) {
                try {
                  await http.post(
                    Uri.parse('https://superjodi.in/new_admin/update_user_payment.php'),
                    body: {
                      'uid': currentUser.value.uid!,
                      'payment_id': paymentId,
                    },
                  );
                } catch (e) {
                  print("DB Payment Update Error: $e");
                }
              }
            }
          }

          // Save Session
          SharedPreferences prefs = await _prefs;
          await prefs.setString('mobile', user.phoneNumber ?? '');
          await prefs.setString('email', user.email ?? '');
          await prefs.setString('user', jsonEncode(currentUser.value.toJson()));
          await prefs.setBool('isLoggedIn', true);

          Get.snackbar('Success', 'Registration Successful!');
          Get.offAll(const HomePage());

        } else if (resData['code'] == '201') {
          Get.snackbar('Registration Error', resData['msg'] ?? 'User already registered.');
        }
      } else {
        Get.snackbar('Error', 'Server response error during registration.');
      }
    } catch (e) {
      print("SignUp Error: $e");
      Get.snackbar('Error', 'Something went wrong during registration.');
    } finally {
      isLoading(false);
    }
  }

  Future<void> loginUser(String email, String password) async {
    final uri = Uri.parse('${baseUrl}onSignin');
    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    try {
      isLoading(true);
      final response = await http
          .post(uri, body: body, headers: {'Content-Type': 'application/json'});

      print("response ${response.body}");
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['code'] == '200') {
          currentUser.value = CombinedUser.fromJson(responseBody['msg'][0]);

          SharedPreferences prefs = await _prefs;
          await prefs.setString('user', jsonEncode(currentUser.value.toJson()));
          await prefs.setString('mobile', currentUser.value.phoneNumber ?? '');
          await prefs.setString('email', currentUser.value.email ?? '');
          await prefs.setBool('isLoggedIn', true);
          Get.offAll(HomePage());
        } else {
          Get.snackbar('Error', 'Invalid credentials');
        }
      } else {
        print('Failed to login');
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<bool> isUserLoggedIn() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool('isLoggedIn') ?? false;
  }

  RxList<CombinedUser> allUsers = <CombinedUser>[].obs;

  Future<void> fetchCurrentUser() async {
    final SharedPreferences prefs = await _prefs;
    final String? mobile = prefs.getString('mobile');
    final String? email = prefs.getString('email');

    if (mobile != null && mobile.isNotEmpty) {
      final userDetails = await getUserDetails(email ?? "");

      if (userDetails['status'] == '200') {
        final data = userDetails['data'] as List<dynamic>;

        if (data.isNotEmpty) {
          data.sort((a, b) => int.parse(b['uid']).compareTo(int.parse(a['uid'])));
          currentUser.value = CombinedUser.fromJson(data[0]);
          print('Current user details: ${currentUser.value.fullName}');
        }
      }
    }
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove('mobile');
    await prefs.setBool('isLoggedIn', false);
    Get.offAll(LoginPage());
  }

  Future<Map<String, dynamic>> getUserDetails(String email) async {
    final uri = Uri.parse('${baseUrl}getUserDetails');
    try {
      final response = await http.post(
        uri,
        body: jsonEncode({'email': email}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> responseData = json.decode(response.body);
          print(responseData);
          return {'status': responseData['code'], 'data': responseData['msg']};
        } catch (e) {
          return {'status': 'error', 'message': 'Failed to parse response'};
        }
      } else {
        return {'status': 'error', 'message': 'Failed to fetch user details'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'Request failed: $e'};
    }
  }

  Future<Map<String, dynamic>> checkExistUser(String email,String mobile) async {
    final uri = Uri.parse('${baseUrl}onCheckUser');
    try {
      final response = await http.post(
        uri,
        body: jsonEncode({'email': email, 'mobile': mobile}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> responseData = json.decode(response.body);
          print(responseData);
          return {'code': responseData['code'], 'msg': responseData['msg']};
        } catch (e) {
          return {'code': 'error', 'msg': 'Failed to parse response'};
        }
      } else {
        return {'code': 'error', 'msg': 'Failed to fetch user details'};
      }
    } catch (e) {
      return {'code': 'error', 'msg': 'Request failed: $e'};
    }
  }
}