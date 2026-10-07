import 'package:app/Theme/theme-colors.dart';
import 'package:app/controllers/data-controller.dart';
import 'package:app/models/form-models/form-data.dart';
import 'package:app/models/registered-user-model.dart';
import 'package:app/views/options.dart';
import 'package:app/views/screens/auth_screens/privacy_policy.dart';
import 'package:app/views/screens/auth_screens/register-page-2.dart';
import 'package:app/views/screens/auth_screens/terms_and_conditions.dart';
import 'package:app/views/screens/privacy-policy-page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/auth-controller.dart';
import '../../../controllers/country_code_controller.dart'; // For date formatting

class RegistrationPage1 extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage1> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final DataController dataController = Get.put(DataController());
  final CountryCodeController countryCodeController =
  Get.put(CountryCodeController());

  String? _selectedGender;
  String? _selectedDay;
  String? _selectedMonth;
  String? _selectedYear;
  String? selectedMotherTongue;
  String? selectedReligion;
  String? selectedCaste;
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  String? selectedProfileCreatedBy;
  String? phoneNumber;
  String? countryCode;
  String? phoneNum;
  bool isValid = false;
  bool isNumberComplete = false;
  DateTime dobDate = DateTime.now();

  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    countryCodeController.fetchCountriesCode();
    dataController.fetchReligions();
    dataController.fetchCountries();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    countryCodeController.fetchCountriesCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_back_rounded),
          ),
        ),
      ),
      body: SingleChildScrollView(
        // Bottom me extra padding add ki gayi hai
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
          bottom: 80.0, // 👈 Extra space for smooth scrolling at the bottom
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Register Now to find your Perfect Partner',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: pinkColor),
              ),
              const SizedBox(height: 10.0),
              Text(
                'We will Help you to find perfect match based on the details you enter here',
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    color: blackColor),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Create Account',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              _buildTextField(_emailController, 'Email', 'Email ID',
                  TextInputType.emailAddress),
              _buildTextField(_passwordController, 'Password', 'Password',
                  TextInputType.text,
                  isPassword: true),
              const SizedBox(height: 20.0),
              const Text(
                'Bride/Groom Details',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              _buildTextField(_fullNameController, 'Full Name',
                  'Enter your full name', TextInputType.text),
              _buildDropdownField('Gender', 'Select Gender', genders,
                      (value) => setState(() => _selectedGender = value), (value) {
                    if (value == null) {
                      return 'Please select your Gender';
                    }
                    return null;
                  }),
              const Text(" Date of Birth"),
              birthDateWidget(),
              _buildDropdownFieldAPI(
                'Mother Tongue',
                "Select Mother Tongue",
                dataController.languages,
                dataController.selectedLanguage,
                    (value) {
                  dataController.selectedLanguage.value = value;
                },
                    (value) {
                  if (value == null) {
                    return 'Please select your Mother Tongue';
                  } else if (value.dataId == "0") {
                    return 'Please select your Mother Tongue';
                  }
                  return null;
                },
              ),
              _buildDropdownFieldAPI(
                'Religion',
                "Select Religion",
                dataController.religions,
                dataController.selectedReligion,
                    (value) {
                  dataController.selectedReligion.value = value;
                  dataController.selectedCaste.value = null;
                  if (value != null) {
                    print("object${dataController.selectedReligion.value}");
                    dataController.fetchCastes(value.dataId);
                  }
                },
                    (value) {
                  if (value == null) {
                    return 'Please select your Religion ';
                  } else if (value.dataId == "0") {
                    return 'Please select your Religion ';
                  }
                  return null;
                },
              ),
              _buildDropdownFieldAPI(
                'Caste',
                "Select Caste",
                dataController.caste,
                dataController.selectedCaste,
                    (value) {
                  dataController.selectedCaste.value = value;
                  if (value != null) {
                    print(
                        "object ${dataController.selectedCaste.value!.dataId}");
                  }
                },
                    (value) {
                  if (value == null) {
                    return 'Please select your Caste';
                  } else if (value.dataId == "0") {
                    return 'Please select your Caste';
                  }
                  return null;
                },
              ),
              _buildDropdownCountryFieldAPI(
                'Country Living In',
                "Select Country",
                dataController.countries,
                dataController.selectedCountry,
                    (value) {
                  dataController.selectedCountry.value = value;
                  dataController.selectedState.value = null;
                  dataController.selectedCity.value = null;
                  if (value != null) {
                    print("object${dataController.selectedCountry.value}");
                    dataController.fetchStates(value.dataId);
                  }
                },
                    (value) {
                  if (value == null) {
                    return 'Please select your Country';
                  } else if (value.dataId == "0") {
                    return 'Please select your Country';
                  }
                  return null;
                },
              ),
              _buildDropdownFieldAPI(
                'State',
                "Select State",
                dataController.states,
                dataController.selectedState,
                    (value) {
                  dataController.selectedState.value = value;
                  dataController.selectedCity.value = null;
                  if (value != null) {
                    dataController.fetchCities(value.dataId);
                  }
                },
                    (value) {
                  if (value == null) {
                    return 'Please select your State';
                  } else if (value.dataId == "0") {
                    return 'Please select your State';
                  }
                  return null;
                },
              ),
              _buildDropdownFieldAPI('City', "Select City ",
                  dataController.cities, dataController.selectedCity, (value) {
                    dataController.selectedCity.value = value;
                  }, (value) {
                    print("not mendatory");
                  }),
              const SizedBox(height: 20.0),
              const Text(
                'Your Contact Details',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              _buildDropdownField(
                  'Profile Created by',
                  "Select relation",
                  profileCreatedByOptions,
                      (value) => setState(() => selectedProfileCreatedBy = value),
                      (value) {}),

              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Obx(() {
                      return DropdownButtonFormField<CountryDataModel>(
                        isExpanded: true,
                        value: countryCodeController.selectedCountryCode.value,
                        decoration: const InputDecoration(
                          labelText: 'Country',
                          border: OutlineInputBorder(),
                        ),
                        items: countryCodeController.countriesCode.map((country) {
                          return DropdownMenuItem<CountryDataModel>(
                            value: country,
                            child: Text(
                              "${country.shortName} (+${country.phoneCode})",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          );
                        }).toList(),
                        onChanged: (CountryDataModel? selected) {
                          countryCodeController.selectedCountryCode.value = selected;

                          if (selected != null) {
                            print("Selected Country ID: ${selected.dataId}");
                            print("Selected Phone Code: +${selected.phoneCode}");
                          }
                        },
                        validator: (value) =>
                        value == null ? 'Please select a country' : null,
                      );
                    }),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (!RegExp(r'^\d+$').hasMatch(value)) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),

              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();

                    if (_phoneController.text.trim().isEmpty) {
                      Get.snackbar('Error', 'Please enter your phone number');
                      return;
                    } else {
                      phoneNumber =
                      "+${countryCodeController.selectedCountryCode.value!.phoneCode}${_phoneController.text.trim()}";

                      RegisteredUser dummyUser = RegisteredUser(
                        email: _emailController.text.trim(),
                        password: _passwordController.text,
                        fullName: _fullNameController.text.trim(),
                        gender: _selectedGender!,
                        day: _selectedDay ?? "",
                        month: _selectedMonth ?? "",
                        year: _selectedYear ?? "",
                        motherTongue:
                        dataController.selectedLanguage.value!.dataName,
                        religion:
                        dataController.selectedReligion.value!.dataName,
                        caste: dataController.selectedCaste.value!.dataName,
                        country: dataController.selectedCountry.value!.dataName,
                        state: dataController.selectedState.value!.dataName,
                        city: dataController.selectedCity.value == null
                            ? ""
                            : dataController.selectedCity.value!.dataName,
                        profileCreatedBy: selectedProfileCreatedBy ?? "",
                        phoneNumber: phoneNumber ?? "",
                        phoneIs: 'Verified',
                        image: 'https://app.com/profile.jpg',
                        language: 'English',
                      );

                      var checkUser = await authController.checkExistUser(
                          _emailController.text.trim(), phoneNumber ?? "");
                      print("usercheck ${checkUser['msg']}");
                      if (checkUser['msg'] ==
                          "User already registerd with this number or email") {
                        Get.snackbar('Error', checkUser['msg']);
                      } else {
                        print("registerUser");
                        Get.to(RegisterPage2(registeredUser: dummyUser));
                      }
                    }
                  }
                },
                child: Container(
                  height: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: pinkColor,
                  ),
                  child: Center(
                    child: Text(
                      'Register & Next',
                      style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              RichText(
                text: TextSpan(
                  text: 'By choosing to continue, you agree to our ',
                  style: const TextStyle(
                    height: 1.6,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(TermsAndConditions()),
                      text: 'TERMS AND CONDITIONS ,',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(PrivacyPolicy()),
                      text: ' PRIVACY POLICY',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40.0), // 👈 Bottom spacing badhai gayi hai
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      String hint, TextInputType inputType,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        obscureText: isPassword,
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
          labelStyle: const TextStyle(fontSize: 20.0),
          hintStyle: TextStyle(fontSize: 14.0, color: greyColorPlan),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter your $label';
          }

          if (controller == _emailController) {
            final emailRegex = RegExp(
              r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
            );

            if (!emailRegex.hasMatch(value.trim())) {
              return 'Please enter a valid email address';
            }
          }

          if (controller == _passwordController) {
            if (value.length < 4) {
              return 'Password must be at least 4 characters';
            }
          }

          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField(
      String label,
      String hint,
      List<String> items,
      ValueChanged<String?> onChanged,
      final FormFieldValidator<String>? validator,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
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
          labelStyle: const TextStyle(fontSize: 20.0),
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        ))
            .toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  Widget birthDateWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 2,
          child: _buildDropdownField('Date', 'date', days,
                  (value) => setState(() => _selectedDay = value), (value) {
                if (value == null) {
                  return 'Please select your Date ';
                }
                return null;
              }),
        ),
        const SizedBox(width: 5),
        Flexible(
          flex: 2,
          child: _buildDropdownField('Month', 'month', months,
                  (value) => setState(() => _selectedMonth = value), (value) {
                if (value == null) {
                  return 'Please select your Month ';
                }
                return null;
              }),
        ),
        const SizedBox(width: 5),
        Flexible(
          flex: 2,
          child: _buildDropdownField('Year', 'year', years,
                  (value) => setState(() => _selectedYear = value), (value) {
                if (value == null) {
                  return 'Please select your year';
                }
                return null;
              }),
        ),
      ],
    );
  }
}

Widget _buildDropdownFieldAPI(
    String label,
    String hint,
    List<DataModel> items,
    Rx<DataModel?> selectedItem,
    ValueChanged<DataModel?> onChanged,
    final FormFieldValidator<DataModel>? validator,
    ) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Obx(() {
      return DropdownButtonFormField<DataModel>(
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
          labelStyle: const TextStyle(fontSize: 20.0),
        ),
        value: selectedItem.value,
        items: items
            .map((item) => DropdownMenuItem<DataModel>(
          value: item,
          child: Text(item.dataName),
        ))
            .toList(),
        onChanged: (DataModel? newValue) {
          selectedItem.value = newValue;
          onChanged(newValue);
        },
        validator: validator,
      );
    }),
  );
}

Widget _buildDropdownCountryFieldAPI(
    String label,
    String hint,
    List<CountryDataModel> items,
    Rx<CountryDataModel?> selectedItem,
    ValueChanged<CountryDataModel?> onChanged,
    final FormFieldValidator<CountryDataModel>? validator,
    ) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Obx(() {
      return DropdownButtonFormField<CountryDataModel>(
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
          labelStyle: const TextStyle(fontSize: 20.0),
        ),
        value: selectedItem.value,
        items: items
            .map((item) => DropdownMenuItem<CountryDataModel>(
          value: item,
          child: Text(item.dataName),
        ))
            .toList(),
        onChanged: (CountryDataModel? newValue) {
          selectedItem.value = newValue;
          onChanged(newValue);
        },
        validator: validator,
      );
    }),
  );
}