import 'dart:convert';

import 'package:app/Theme/theme-colors.dart';
import 'package:app/models/MembershipPlan.dart';
import 'package:app/views/components/membership-card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MembershipPage extends StatefulWidget {
  const MembershipPage({super.key});

  @override
  State<MembershipPage> createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  late Razorpay _razorpay;

  MembershipPlan? _selectedPlan;
  bool _isPaying = false;

  List<MembershipPlan> plans = [];
  bool isLoading = true;

  // ================= INIT =================
  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    fetchPlans();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  // ================= FETCH PLANS =================
  Future<void> fetchPlans() async {
    const url = 'https://superjodi.in/API/index.php?p=getAllPlans';

    try {
      setState(() => isLoading = true);

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body['code'] == 200 && body['msg'] is List) {
          plans = body['msg']
              .map<MembershipPlan>((e) => MembershipPlan.fromJson(e))
              .toList();
        }
      }
    } catch (e) {
      debugPrint("Plan API Error: $e");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }
  Future<Map<String, String>?> createRazorpayOrder({
    required String userId,
    required int amount,
  }) async {
    const url = "https://superjodi.in/API/index.php?p=createorder";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "fb_id": userId,
          "amount": amount,
          "currency": "INR",
        }),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body['code'] == 200 && body['msg'].isNotEmpty) {
          return {
            "order_id": body['msg'][0]['response'],
            "key": body['msg'][0]['rzp_key'],
          };
        }
      }
    } catch (e) {
      debugPrint("Create Order Error: $e");
    }
    return null;
  }

  // ================= RAZORPAY =================
  Future<void> openCheckout(MembershipPlan plan) async {
    if (_isPaying) return;
    _isPaying = true;

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('my_uid');

      if (userId == null) {
        _isPaying = false;
        _showSnack("Please login first");
        return;
      }

      final int amount = int.tryParse(plan.amount) ?? 0;
      if (amount <= 0) {
        _isPaying = false;
        _showSnack("Invalid amount");
        return;
      }

      _selectedPlan = plan;

      // 🔥 CREATE ORDER FROM BACKEND
      final orderData = await createRazorpayOrder(
        userId: userId,
        amount: amount,
      );

      if (orderData == null) {
        _isPaying = false;
        _showSnack("Unable to create order");
        return;
      }

      final options = {
        'key': orderData['key'],                 // 🔥 from backend
        'order_id': orderData['order_id'],       // 🔥 REQUIRED
        'amount': amount * 100,
        'currency': 'INR',
        'name': 'AOneJodi',
        'description': plan.name,
        'prefill': {
          'contact': '9090909900',
          'email': 'sun@gmail.com',
        },
        'theme': {
          'color': '#E91E63',
        },
      };

      _razorpay.open(options);
    } catch (e) {
      _isPaying = false;
      debugPrint("Razorpay Error: $e");
    }
  }

  // ================= CALLBACKS =================
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    _isPaying = false;

    if (!mounted || _selectedPlan == null) return;

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('my_uid');

    if (userId == null) return;

    await insertTransaction(
      userId: userId,
      packageId: _selectedPlan!.id,
      amount: _selectedPlan!.amount,
      transactionId: response.paymentId ?? '',
    );

    _showSnack("Payment Successful 🎉");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    _isPaying = false;
    _showSnack("Payment Failed ❌");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    _isPaying = false;
  }

  // ================= TRANSACTION =================
  Future<void> insertTransaction({
    required String userId,
    required String packageId,
    required String amount,
    required String transactionId,
  }) async {
    const url = "https://superjodi.in/API/index.php?p=onInsertTransaction";

    try {
      await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "user_id": userId,
          "package_id": packageId,
          "amount": amount,
          "transaction_id": transactionId,
        }),
      );
    } catch (e) {
      debugPrint("Insert Transaction Error: $e");
    }
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pinkColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Membership Plan',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : plans.isEmpty
              ? const Center(child: Text("No Plans Available"))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: plans.length,
                  itemBuilder: (_, index) {
                    final plan = plans[index];
                    return InkWell(
                      onTap: () => openCheckout(plan),
                      child: MembershipCard(
                        planName: plan.name,
                        price: plan.amount,
                        contactNum: plan.contacts,
                        validity: plan.validity,
                        ifSelected: false,
                      ),
                    );
                  },
                ),
    );
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
