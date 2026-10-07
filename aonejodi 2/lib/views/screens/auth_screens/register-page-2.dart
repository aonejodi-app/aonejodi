import 'dart:convert';

import 'package:app/Theme/theme-colors.dart';
import 'package:app/controllers/auth-controller.dart';
import 'package:app/controllers/photo-pick-controller.dart';
import 'package:app/models/combined-user-model.dart';
import 'package:app/models/registered-user-model.dart';
import 'package:app/views/options.dart';
import 'package:app/views/screens/auth_screens/privacy_policy.dart';
import 'package:app/views/screens/auth_screens/terms_and_conditions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../privacy-policy-page.dart';

class RegisterPage2 extends StatefulWidget {
  final AuthController authController = Get.find();

  final RegisteredUser registeredUser;

  RegisterPage2({super.key, required this.registeredUser});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<RegisterPage2> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _placeOfBirthController = TextEditingController();
  final TextEditingController _timeOfBirthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _educationCityController =
      TextEditingController();
  final TextEditingController _occupationCityController =
      TextEditingController();

  final AuthController authController = Get.find();

  final PhotoUploadController photoPickerController =
      Get.put(PhotoUploadController());

  String? _selectedMaritalStatus;
  String? _selectedHeight;
  String? _selectedAge;
  String? selectedBodyType;
  String? selectedEatingHabit;
  String? selectedDrinkingHabit;
  String? selectedSmokingHabit;
  String? _selectedComplexion;
  String? _selectedAnnualIncome;
  String? _selectedFamilyType;
  String? selectedFamilyStatus;
  String? _selectedFathersOccupation;
  String? _selectedMothersOccupation;
  String? _selectedBrothersOccupation;
  String? _selectedSistersOccupation;
  String? _selectedPhysicalStatus;
  String? _selectedManglik;
  String? _selectedEducationCity;
  String? _selectedOccupationCity;
  String? _selectedHour;
  String? _selectedMinutes;
  String? _selectedTime;
  bool isPhotoSelected = false;
  List<String> hours = generateHourList();
  List<String> minutes = generateMinutesList();

  @override
  Widget build(BuildContext context) {
    String imageEncoded = '';
    bool _isChecked = false;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 SizedBox(
                  height: 10,
                ),
                 Text(
                  'Final Step of Registration',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: pinkColor,
                      fontSize: 22),
                ),
                 SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     SizedBox(height: 20.0),
                     Text(
                      'Basic Details',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),

                    _buildDropdownField('Age', 'Select age', ages,
                        (value) => setState(() => _selectedAge = value)),

                    // _buildTextField(_ageController, 'Age', 'Enter your age',
                    //     TextInputType.number),
                    _buildTextField(_placeOfBirthController, 'Place of Birth',
                        'place of birth', TextInputType.text),

                    Text(" Time of Birth"),
                    SizedBox(
                      height: 5,
                    ),
                    birthDateWidget(),
                    // _buildTextField(_timeOfBirthController, 'Time of Birth',
                    //     'HH/MM', TextInputType.datetime),
                    _buildDropdownField('Height', 'Select height', heights,
                        (value) => setState(() => _selectedHeight = value)),
                    // _buildTextField(_heightController, 'Height', '(in cm)',
                    //     TextInputType.number),
                    _buildDropdownField(
                        'Marital Status',
                        'Select marital status',
                        maritalStatuses,
                        (value) =>
                            setState(() => _selectedMaritalStatus = value)),
                    _buildDropdownFieldOptional(
                      'Body Type',
                      'Select body type',
                      bodyTypes,
                      (value) => setState(() => selectedBodyType = value),
                      (value) {
                        // No validation required, so return null.
                        return null; // City is optional, so no need to validate.
                      },
                    ),

                     SizedBox(height: 20.0),
                     Text(
                      'Your Personal Information',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    _buildDropdownFieldOptional(
                      'Eating Habit',
                      'Select eating habit',
                      eatingHabits,
                      (value) => setState(() => selectedEatingHabit = value),
                      (value) {
                        // No validation required, so return null.
                        return null; // City is optional, so no need to validate.
                      },
                    ),
                    _buildDropdownFieldOptional(
                      'Drinking Habit',
                      'Select drinking habit',
                      drinkingHabits,
                      (value) => setState(() => selectedDrinkingHabit = value),
                      (value) {
                        // No validation required, so return null.
                        return null; // City is optional, so no need to validate.
                      },
                    ),
                    _buildDropdownFieldOptional(
                      'Smoking Habit',
                      'Select smoking habit',
                      smokingHabits,
                      (value) => setState(() => selectedSmokingHabit = value),
                      (value) {
                        // No validation required, so return null.
                        return null; // City is optional, so no need to validate.
                      },
                    ),
                    _buildDropdownFieldOptional(
                      'Complexion',
                      'Select complexion',
                      complexions,
                      (value) => setState(() => _selectedComplexion = value),
                      (value) {
                        // No validation required, so return null.
                        return null; // City is optional, so no need to validate.
                      },
                    ),
                    _buildDropdownFieldOptional(
                      'Annual Income',
                      'Select annual income',
                      annualIncomes,
                      (value) => setState(() => _selectedAnnualIncome = value),
                      (value) {
                        // No validation required, so return null.
                        return null; // City is optional, so no need to validate.
                      },
                    ),
                     SizedBox(height: 20.0),
                     Text(
                      'Family Details',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    _buildDropdownFieldOptional(
                      'Family Type',
                      'Select',
                      familyTypes,
                      (value) => setState(() => _selectedFamilyType = value),
                      (value) {
                        // No validation required, so return null.
                        return null; // City is optional, so no need to validate.
                      },
                    ),
                    _buildDropdownFieldOptional(
                      'Family Status',
                      ' Select family status',
                      familyStatuses,
                      (value) => setState(() => selectedFamilyStatus = value),
                      (value) {
                        // No validation required, so return null.
                        return null; // City is optional, so no need to validate.
                      },
                    ),
                    _buildDropdownFieldOptional(
                      'Father\'s Occupation',
                      ' Select father\'s occupation',
                      fathersOccupations,
                      (value) =>
                          setState(() => _selectedFathersOccupation = value),
                      (value) {
                        // No validation required, so return null.
                        return null; // City is optional, so no need to validate.
                      },
                    ),
                    _buildDropdownFieldOptional(
                      'Mother\'s Occupation',
                      ' Select mother\'s occupation',
                      mothersOccupations,
                      (value) =>
                          setState(() => _selectedMothersOccupation = value),
                      (value) {
                        // No validation required, so return null.
                        return null; // City is optional, so no need to validate.
                      },
                    ),
                    _buildDropdownFieldOptional(
                      'Brothers ',
                      'Select  brother',
                      brothersOccupations,
                      (value) =>
                          setState(() => _selectedBrothersOccupation = value),
                      (value) {
                        // No validation required, so return null.
                        return null; // City is optional, so no need to validate.
                      },
                    ),
                    _buildDropdownFieldOptional(
                      'Sisters',
                      ' Select sister',
                      sistersOccupations,
                      (value) =>
                          setState(() => _selectedSistersOccupation = value),
                      (value) {
                        // No validation required, so return null.
                        return null; // City is optional, so no need to validate.
                      },
                    ),
                     SizedBox(height: 20.0),
                     Text(
                      'Education and Employment',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    _buildDropdownField(
                        'Education ',
                        'education ',
                        educations,
                        (value) =>
                            setState(() => _selectedEducationCity = value)),
                    _buildDropdownField(
                        'Occupation ',
                        ' occupation ',
                        occupations,
                        (value) =>
                            setState(() => _selectedOccupationCity = value)),

                     SizedBox(height: 20.0),
                     Text(
                      'Manglik Status',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: manglikOptions.map((option) {
                          return Row(
                            children: [
                              Radio<String>(
                                value: option,
                                groupValue: _selectedManglik,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedManglik = value;
                                  });
                                },
                                activeColor: pinkColor,
                              ),
                              Expanded(
                                child: Text(option),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                     SizedBox(height: 20.0),

                     SizedBox(height: 20.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            // Implement photo upload functionality here
                            await photoPickerController.pickImage();
                          },
                          child: Container(
                            padding:  EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: isPhotoSelected
                                  ? Border.all(color: Colors.red)
                                  : Border.all(color: Colors.transparent),
                            ),
                            child: Container(
                              padding:  EdgeInsets.all(10),
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: pinkColor,
                              ),
                              child:  Center(
                                child: Text(
                                  'Add Photo',
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // if (photoPickerController.imageBase64.value ==
                    //     null)...[
                     SizedBox(
                      height: 5,
                    ),
                    isPhotoSelected
                        ?  Text(
                            'Please Select your Photo',
                            style: TextStyle(fontSize: 12.0, color: Colors.red),
                          )
                        :  SizedBox.shrink(),
                    // ],
                     SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      // Check if imageBase64 has a value
                      Uint8List? imageBytes;
                      if (photoPickerController.imageBase64.value != null) {
                        imageBytes = base64Decode(
                            photoPickerController.imageBase64.value!);
                      }

                      return AspectRatio(
                        aspectRatio: 16 / 9,
                        child: imageBytes != null
                            ? Image.memory(
                                imageBytes,
                                fit: BoxFit.fill,
                              )
                            : null,
                      );
                    }),
                    // Stack(
                    //   children: [
                    //     Obx(() {
                    //       // Check if imageBase64 has a value
                    //       Uint8List? imageBytes;
                    //       if (photoPickerController.imageBase64.value != null) {
                    //         imageBytes = base64Decode(
                    //             photoPickerController.imageBase64.value!);
                    //       }
                    //
                    //       return GestureDetector(
                    //         onTap: () async {
                    //           // Pick image when tapped
                    //           await photoPickerController.pickImage();
                    //         },
                    //         child: CircleAvatar(
                    //           radius: 60,
                    //           backgroundColor:
                    //            Color.fromARGB(255, 29, 28, 28),
                    //           backgroundImage: imageBytes != null
                    //               ? MemoryImage(imageBytes)
                    //               : null,
                    //           // Use MemoryImage if imageBytes is not null
                    //           child: imageBytes == null
                    //               ? CircleAvatar(
                    //             radius: 59,
                    //             backgroundColor:
                    //             Color.fromARGB(255, 255, 255, 255),
                    //             child: Icon(Icons.person,
                    //                 size: 60, color: Colors.grey[300]),
                    //           )
                    //               : null,
                    //         ),
                    //       );
                    //     }),
                    //     Positioned(
                    //       bottom: 0,
                    //       right: 0,
                    //       child: CircleAvatar(
                    //         radius: 21,
                    //         backgroundColor: Colors.black,
                    //         child: CircleAvatar(
                    //           radius: 20,
                    //           backgroundColor: Colors.white,
                    //           child: IconButton(
                    //             icon: Icon(Icons.camera_alt, size: 23),
                    //             onPressed: () async {
                    //               // Implement photo upload functionality here
                    //               await photoPickerController.pickImage();
                    //             },
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                     SizedBox(height: 8.0),
                    RichText(
                      text: TextSpan(
                        text: 'By choosing to continue, you agree to our ',
                        style:  TextStyle(
                          height: 1.6,
                          color: Colors.black, // Default text color
                          fontWeight: FontWeight.normal,
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to( TermsAndConditions()),
                            text: 'TERMS AND CONDITIONS ,',
                            style:  TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors
                                  .blue, // You can change the color if necessary
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(PrivacyPolicy()),
                            text: ' PRIVACY POLICY',
                            style:  TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors
                                  .blue, // You can change the color if necessary
                            ),
                          ),
                        ],
                      ),
                    ),

                     SizedBox(height: 8.0),

                    Center(
                      child: GestureDetector(
                        onTap: () async {

                          print("object ${widget.registeredUser.phoneNumber} ${_formKey.currentState?.validate()}");
                          if (photoPickerController.imageBase64.value ==
                              null ) {
                            setState(() {
                              isPhotoSelected = true;
                            });
                            Get.snackbar('Select Photo', 'Please add photo');
                          }
                          else if (_formKey.currentState?.validate() ?? false) {
                            // if (photoPickerController.imageBase64.value ==
                            //     null) {
                            //   setState(() {
                            //     isPhotoSelected = true;
                            //   });
                            //   Get.snackbar('Select Photo', 'Please add photo');
                            // } else {
                              setState(() {
                                isPhotoSelected = false;
                              });
                              CombinedUser newUser = CombinedUser(
                                image:
                                    photoPickerController.imageBase64.value ??
                                        "",
                                employed: '',
                                profession: _selectedOccupationCity ?? "",
                                music: '',
                                sports: '',
                                movies: '',
                                outfit: '',
                                about: '',
                                password: widget.registeredUser.password,
                                smoking: selectedSmokingHabit ?? "",
                                status: selectedFamilyStatus ?? "",
                                drinking: selectedDrinkingHabit ?? "",
                                eating: selectedEatingHabit ?? "",
                                motherTongue:
                                    widget.registeredUser.motherTongue,
                                religion: widget.registeredUser.religion,
                                caste: widget.registeredUser.caste,
                                country: widget.registeredUser.country,
                                state: widget.registeredUser.state,
                                city: widget.registeredUser.city,
                                profileCreatedBy:
                                    widget.registeredUser.profileCreatedBy,
                                phoneNumber: widget.registeredUser.phoneNumber,
                                phoneIs: widget.registeredUser.phoneIs,
                                language: widget.registeredUser.language,
                                birthTime:
                                    "$_selectedHour:$_selectedMinutes$_selectedTime",
                                physicalStatus: '',
                                // Default value if null
                                medical: _selectedPhysicalStatus ?? '',
                                // Default value if null
                                father: _selectedFathersOccupation ?? '',
                                // Default value if null
                                mother: _selectedMothersOccupation ?? '',
                                // Default value if null
                                brothers: _selectedBrothersOccupation ?? '',
                                // Default value if null
                                sisters: _selectedSistersOccupation ?? '',
                                // Default value if null
                                education: _selectedEducationCity ?? '',
                                // Default value if null
                                email: widget.registeredUser.email,
                                fullName: widget.registeredUser.fullName,
                                gender: widget.registeredUser.gender,
                                day: widget.registeredUser.day,
                                month: widget.registeredUser.month,
                                year: widget.registeredUser.year,
                                age: _selectedAge!.replaceAll("yrs", '') ?? "",
                                height: _selectedHeight ?? "",
                                maritalStatus: _selectedMaritalStatus ?? '',
                                // Default value if null
                                complexion: _selectedComplexion ?? '',
                                // Default value if null
                                annualIncome: _selectedAnnualIncome ?? '',
                                // Default value if null
                                familyType: _selectedFamilyType ?? '',
                                // Default value if null
                                fathersOccupation:
                                    _selectedFathersOccupation ?? '',
                                // Default value if null
                                mothersOccupation:
                                    _selectedMothersOccupation ?? '',
                                // Default value if null
                                manglik: _selectedManglik ?? '',
                                familyStatus: selectedFamilyStatus ?? "",
                                ageBetween: _selectedAge ?? "",
                                image2: "",
                                image3: '',
                                bodyType: selectedBodyType ?? "",
                                uid: '',
                                birthPlace:
                                    _placeOfBirthController.text.isNotEmpty
                                        ? _placeOfBirthController.text
                                        : "",
                                // Default value if null
                              );

                              print("newUser$newUser");
                              // var checkUser =
                              //     await authController.checkExistUser(
                              //         widget.registeredUser.email,
                              //         widget.registeredUser.phoneNumber);
                              // print("usercheck ${checkUser['msg']}");
                              // if (checkUser['msg'] ==
                              //     "User already registerd with this number or email") {
                              //   Get.snackbar('Error', checkUser['msg']);
                              // } else {
                                print("registerUser");
                                authController.registerUser(newUser);
                            //  }
                           // }
                          }
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: pinkColor,
                          ),
                          child:  Center(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      String hint, TextInputType inputType,
      {bool isPassword = false}) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey[300]!), // light grey border
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey[300]!), // light grey border
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey[300]!), // light grey border
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle:  TextStyle(fontSize: 20),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField(String label, String hint, List<String> options,
      ValueChanged<String?> onChanged) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        isDense: true,
        isExpanded: true,
        hint: Text(hint),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey[300]!), // light grey border
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey[300]!), // light grey border
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey[300]!), // light grey border
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle:  TextStyle(fontSize: 20),
        ),
        items: options.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownFieldOptional(
    String label,
    String hint,
    List<String> items,
    ValueChanged<String?> onChanged,
    final FormFieldValidator<String>? validator,
  ) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        isDense: true,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle:  TextStyle(fontSize: 20.0),
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: onChanged,
        validator: validator,
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Please select your $label';
        //   }
        //   return null;
        // },
      ),
    );
  }

  Widget birthDateWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 2,
          child: _buildDropdownFieldOptional(
            'Hours',
            'hours',
            hours,
            (value) => setState(() => _selectedHour = value),
            (value) {
              // No validation required, so return null.
              return null; // City is optional, so no need to validate.
            },
          ),
        ),
         SizedBox(
          width: 5,
        ),
        Flexible(
          flex: 2,
          child: _buildDropdownFieldOptional(
            'Minutes',
            'minutes',
            minutes,
            (value) => setState(() => _selectedMinutes = value),
            (value) {
              // No validation required, so return null.
              return null; // City is optional, so no need to validate.
            },
          ),
        ),
         SizedBox(
          width: 5,
        ),
        Flexible(
          flex: 2,
          child: _buildDropdownFieldOptional(
            'AM/PM',
            'AM/PM',
            time,
            (value) => setState(() => _selectedTime = value),
            (value) {
              // No validation required, so return null.
              return null; // City is optional, so no need to validate.
            },
          ),
        ),
      ],
    );
  }
}
