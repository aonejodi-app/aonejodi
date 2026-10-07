import 'package:app/Theme/theme-colors.dart';
import 'package:app/controllers/verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth-controller.dart';
import '../../models/combined-user-model.dart';

class ProfileVerificationPage extends StatefulWidget {
  const ProfileVerificationPage({super.key});

  @override
  _ProfileVerificationPageState createState() =>
      _ProfileVerificationPageState();
}

class _ProfileVerificationPageState extends State<ProfileVerificationPage> {
  final AuthController authController = Get.find();
  final VerificationController verificationController =
      Get.put(VerificationController());

  String? _selectedOption;
  final List<String> _options = ['Pan Card', 'Aadhaar Card', 'Driving License'];
  final TextEditingController _cardController = TextEditingController();

  void _verifyUser() {
    final CombinedUser user = authController.currentUser.value;
    final String inputNumber = _cardController.text.trim();
    final String email = user.email;

    if (inputNumber.isEmpty || _selectedOption == null) {
      Get.snackbar(
          "Error", "Please select a verification type and provide the number",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (_selectedOption == 'Pan Card') {
      verificationController.verifyUserPanCard(inputNumber, email);
    } else if (_selectedOption == 'Aadhaar Card') {
      verificationController.verifyUserAdhaar(inputNumber, email);
    } else if (_selectedOption == 'Driving License') {
      final String dob =
          '${user.day ?? ''}-${user.month ?? ''}-${user.year ?? ''}' ?? ""; // Fetch DOB from AuthController
      verificationController.verifyUserDL(inputNumber, email, dob);
    }
  }

  @override
  Widget build(BuildContext context) {
    final CombinedUser user = authController.currentUser.value;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Row(
                  children: [
                    const Icon(Icons.verified, color: Colors.blue, size: 27),
                    const SizedBox(width: 8),
                    const Text('Verify Your Profile',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                    "Profile verification is now compulsory to ensure safety and authenticity on appJodi"),
                const SizedBox(height: 45),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: _options.map((option) {
                    bool isSelected = _selectedOption == option;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedOption = option;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 22),
                        decoration: BoxDecoration(
                          color: isSelected ? pinkColor : whiteColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(18)),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Text(
                          option,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    Icon(Icons.verified, color: Colors.green[500], size: 20),
                    const SizedBox(width: 4),
                    const Text('Your information will be 100% safe & private'),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _cardController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    hintText:
                        "${user.fullName}'s ${_selectedOption ?? "Verification Number"}",
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (text){
                    _cardController.text = text.toUpperCase();
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: verificationController.isVerificationInProgress.value ||
                              authController.currentUser.value.isverified == '1'
                      ? (){Get.snackbar("Already Verified", "Your profile is already verified",
                          snackPosition: SnackPosition.TOP);}:
                       _verifyUser,
                  child: Obx(() => Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: verificationController
                                  .isVerificationInProgress.value || authController.currentUser.value.isverified == '1'
                              ? Colors.grey
                              : pinkColor,
                        ),
                        child: Center(
                          child: Text(
                            verificationController
                                    .isVerificationInProgress.value
                                ? 'Verifying...'
                                : 'Verify Now',
                            style: const TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      )),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
