import 'dart:convert';
import 'dart:typed_data';

import 'package:app/Theme/theme-colors.dart';
import 'package:app/controllers/data-controller.dart';
import 'package:app/controllers/edit-page-image-controller.dart';
import 'package:app/controllers/edit-user-controller.dart';
import 'package:app/models/combined-user-model.dart';
import 'package:app/models/form-models/form-data.dart';
import 'package:app/views/components/pink-button.dart';
import 'package:app/views/options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:html_unescape/html_unescape.dart';

class EditProfilePage extends StatefulWidget {
  final CombinedUser userDetail;

  const EditProfilePage({super.key, required this.userDetail});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final EditUserController editUserController = Get.put(EditUserController());
  final _formKey = GlobalKey<FormState>();
  final PhotoUploadControllerEditPage photoPickerController =
  Get.put(PhotoUploadControllerEditPage());
  final DataController dataController = Get.put(DataController());

  late String _fName;
  late String _gender;
  late String _day;
  late String _month;
  late String _year;
  late String _motherTongue;
  late String _religion;
  late String _caste;
  late String _country;
  late String _state;
  late String _city;
  late String _profileCreatedBy;
  late String _phoneNumber;
  late String _email;
  late String _phoneIs;
  late String _image;
  late String _image2;
  late String _image3;
  late String _language;
  late String _birthTime;
  late String _physicalStatus;
  late String _medical;
  late String _father;
  late String _fathersOccupation;
  late String _mother;
  late String _mothersOccupation;
  late String _brothers;
  late String _sisters;
  late String _height;
  late String selectedBodyType;
  late String _education;
  late String _employed;
  late String _complexion;
  late String _profession;
  late String _music;
  late String _sports;
  late String _movies;
  late String _maritalStatus;
  late String _outfit;
  late String _about;
  late String _annualIncome;
  late String _smoking;
  late String _status;
  late String _drinking;
  late String _eating;
  String? _selectedAge;
  late bool isRemoveProfile = false;
  String? _selectedOccupationCity;
  late String _manglik;
  late String _familyType;
  late String _familyStatus;
  late String _bodyType;
  late String _ageBetween;
  late String _birthPlace;
  late String _passWord;
  late String _birthHour;
  late String _birthMinute;
  late String _birthM;
  final TextEditingController _placeOfBirthController = TextEditingController();

  List<String> hours = generateHourList();
  List<String> minutes = generateMinutesList();

  String? _selectedHour;
  String? _selectedMinutes;
  String? _selectedTime;

  @override
  void initState() {
    super.initState();
    final u = widget.userDetail;

    _fName = u.fullName ?? '';
    _gender = u.gender ?? '';
    _day = u.day ?? '';
    _month = u.month ?? '';
    _year = u.year ?? '';
    _motherTongue = u.motherTongue ?? '';
    _religion = u.religion ?? '';
    _caste = u.caste ?? '';
    _country = u.country ?? '';
    _state = u.state ?? '';
    _city = u.city ?? '';
    _profileCreatedBy = u.profileCreatedBy ?? '';
    _phoneNumber = u.phoneNumber ?? '';
    _email = u.email ?? '';
    _bodyType = u.bodyType ?? '';
    _phoneIs = u.phoneIs ?? '';
    _image = u.image ?? '';
    _image2 = u.image2 ?? '';
    _image3 = u.image3 ?? '';
    _language = u.language ?? '';

    _birthTime = u.birthTime ?? '';
    if (_birthTime.length >= 7) {
      _birthHour = _birthTime.substring(0, 2);
      _birthMinute = _birthTime.substring(3, 5);
      _birthM = _birthTime.substring(5, 7);
    } else {
      _birthHour = '';
      _birthMinute = '';
      _birthM = '';
    }

    _physicalStatus = u.physicalStatus ?? '';
    _medical = u.medical ?? '';
    _father = u.father ?? '';
    _fathersOccupation = u.fathersOccupation ?? '';
    _mother = u.mother ?? '';
    _mothersOccupation = u.mothersOccupation ?? '';
    _brothers = u.brothers ?? '';
    _sisters = u.sisters ?? '';
    _height = u.height ?? '';
    _education = u.education ?? '';
    _employed = u.employed ?? '';
    _complexion = u.complexion ?? '';
    _profession = u.profession ?? '';
    _music = u.music ?? '';
    _sports = u.sports ?? '';
    _movies = u.movies ?? '';
    _maritalStatus = u.maritalStatus ?? '';
    _outfit = u.outfit ?? '';
    _about = u.about ?? '';
    _annualIncome = u.annualIncome ?? '';
    _smoking = u.smoking ?? '';
    _status = u.status ?? '';
    _drinking = u.drinking ?? '';
    _eating = u.eating ?? '';
    _selectedAge = u.age ?? '';
    _manglik = u.manglik ?? '';
    _familyType = u.familyType ?? '';
    _familyStatus = u.familyStatus ?? '';
    _ageBetween = u.ageBetween ?? '';
    _birthPlace = u.birthPlace ?? '';
    _passWord = u.password ?? '';
  }

  @override
  Widget build(BuildContext context) {
    String? pickedImage2 = '', pickedImage3 = '', pickedImage4 = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile', style: TextStyle(color: pinkColor)),
        backgroundColor: whiteColor,
        centerTitle: true,
        leading: IconButton(
          icon: const BackButtonIcon(),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Scrollbar(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Container(
                    width: (MediaQuery.of(context).size.width -
                        MediaQuery.of(context).size.width / 1.4),
                    height: (MediaQuery.of(context).size.width -
                        MediaQuery.of(context).size.width / 1.4),
                    decoration: BoxDecoration(
                      image: _image.isNotEmpty
                          ? DecorationImage(
                        image: NetworkImage(_image),
                        fit: BoxFit.cover,
                      )
                          : null,
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    child: _image.isEmpty
                        ? const Icon(Icons.person, size: 50, color: Colors.grey)
                        : null,
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    Uint8List? imageBytes1, imageBytes2, imageBytes3;

                    if (photoPickerController.imageBase64_1.value != null &&
                        photoPickerController.imageBase64_1.value!.isNotEmpty) {
                      isRemoveProfile = false;
                      pickedImage2 = photoPickerController.imageBase64_1.value!;
                      imageBytes1 = base64Decode(pickedImage2!);
                    }
                    if (photoPickerController.imageBase64_2.value != null &&
                        photoPickerController.imageBase64_2.value!.isNotEmpty) {
                      pickedImage3 = photoPickerController.imageBase64_2.value!;
                      imageBytes2 = base64Decode(pickedImage3!);
                    }
                    if (photoPickerController.imageBase64_3.value != null &&
                        photoPickerController.imageBase64_3.value!.isNotEmpty) {
                      pickedImage4 = photoPickerController.imageBase64_3.value!;
                      imageBytes3 = base64Decode(pickedImage4!);
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildImagePickerBox(1, imageBytes1, _image),
                        _buildImagePickerBox(2, imageBytes2, _image2),
                        _buildImagePickerBox(3, imageBytes3, _image3),
                      ],
                    );
                  }),
                  _buildSectionTitle('Basic Details'),
                  _buildTextField('Full Name', _fName,
                          (value) => setState(() => _fName = value)),
                  birthDateWidget(),
                  birthTimeWidget(),
                  _buildDropdownField(
                      'Age',
                      _selectedAge,
                      ages,
                          (value) => setState(() => _selectedAge = value)),
                  _buildTextField('Place of Birth', _birthPlace,
                          (value) => setState(() => _birthPlace = value)),
                  _buildDropdownFieldAPI(
                    'Mother Tongue',
                    _motherTongue.isEmpty ? "Select Mother Tongue" : _motherTongue,
                    dataController.languages,
                    dataController.selectedLanguage,
                        (value) {
                      dataController.selectedLanguage.value = value;
                      _motherTongue = value?.dataName ?? "";
                    },
                        (value) => null,
                  ),
                  _buildDropdownFieldAPI(
                    'Religion',
                    _religion.isEmpty ? "Select Religion" : _religion,
                    dataController.religions,
                    dataController.selectedReligion,
                        (value) {
                      dataController.selectedReligion.value = value;
                      _religion = value?.dataName ?? "";
                      dataController.selectedCaste.value = null;
                      if (value != null) {
                        dataController.fetchCastes(value.dataId);
                      }
                    },
                        (value) => null,
                  ),
                  _buildDropdownFieldAPI(
                    'Caste',
                    _caste.isEmpty ? "Select Caste" : _caste,
                    dataController.caste,
                    dataController.selectedCaste,
                        (value) {
                      dataController.selectedCaste.value = value;
                      _caste = value?.dataName ?? "";
                    },
                        (value) => null,
                  ),
                  _buildDropdownField(
                      'Height',
                      _height,
                      heights,
                          (value) => setState(() => _height = value ?? "")),
                  _buildDropdownField(
                      'Body Type',
                      _bodyType,
                      bodyTypes,
                          (value) => setState(() => _bodyType = value ?? "")),
                  _buildDropdownField(
                      'Marital Status',
                      _maritalStatus,
                      maritalStatuses,
                          (value) => setState(() => _maritalStatus = value ?? "")),
                  _buildDropdownCountryFieldAPI(
                    'Country Living In',
                    _country.isEmpty ? "Select Country" : _country,
                    dataController.countries,
                    dataController.selectedCountry,
                        (value) {
                      dataController.selectedCountry.value = value;
                      dataController.selectedState.value = null;
                      dataController.selectedCity.value = null;
                      if (value != null) {
                        dataController.fetchStates(value.dataId);
                      }
                    },
                        (value) {
                      if (value == null) {
                        return 'Please select your Country';
                      }
                      return null;
                    },
                  ),
                  _buildDropdownFieldAPI(
                    'State',
                    _state.isEmpty ? "Select State" : _state,
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
                      }
                      return null;
                    },
                  ),
                  _buildDropdownFieldAPI(
                    'City',
                    _city.isEmpty ? "Select City" : _city,
                    dataController.cities,
                    dataController.selectedCity,
                        (value) {
                      dataController.selectedCity.value = value;
                    },
                        (value) {},
                  ),
                  const SizedBox(height: 10.0),
                  _buildSectionTitle('Your Personal Information'),
                  const SizedBox(height: 10.0),
                  _buildDropdownField(
                    'Profile Created by',
                    _profileCreatedBy,
                    profileCreatedByOptions,
                        (value) => setState(() => _profileCreatedBy = value ?? ""),
                  ),
                  IntlPhoneField(
                    initialValue: _phoneNumber,
                    focusNode: FocusNode(),
                    style: const TextStyle(fontSize: 14),
                    keyboardType: TextInputType.phone,
                    dropdownIcon: const Icon(Icons.arrow_downward, size: 28),
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      _phoneNumber = phone.countryCode + phone.number;
                    },
                  ),
                  _buildDropdownField(
                    'Eating Habit',
                    _eating,
                    eatingHabits.map((e) => cleanText(e)).toList(),
                        (value) {
                      setState(() {
                        _eating = cleanText(value ?? "");
                      });
                    },
                  ),
                  _buildDropdownField(
                      'Drinking Habit',
                      _drinking,
                      drinkingHabits,
                          (value) => setState(() => _drinking = value ?? "")),
                  _buildDropdownField(
                      'Smoking Habit',
                      _smoking,
                      smokingHabits,
                          (value) => setState(() => _smoking = value ?? "")),
                  _buildDropdownField(
                      'Complexion',
                      _complexion,
                      complexions,
                          (value) => setState(() => _complexion = value ?? "")),
                  _buildDropdownField(
                      'Annual Income',
                      _annualIncome,
                      annualIncomes,
                          (value) => setState(() => _annualIncome = value ?? "")),
                  const SizedBox(height: 10.0),
                  _buildSectionTitle('Family Details'),
                  const SizedBox(height: 10.0),
                  _buildDropdownField(
                      'Family Type',
                      _familyType,
                      familyTypes,
                          (value) => setState(() => _familyType = value ?? "")),
                  _buildDropdownField(
                      'Family Status',
                      _familyStatus,
                      familyStatuses,
                          (value) => setState(() => _familyStatus = value ?? "")),
                  _buildDropdownField(
                      'Father\'s Occupation',
                      _fathersOccupation,
                      fathersOccupations,
                          (value) =>
                          setState(() => _fathersOccupation = value ?? "")),
                  _buildDropdownField(
                      'Mother\'s Occupation',
                      _mothersOccupation,
                      mothersOccupations,
                          (value) =>
                          setState(() => _mothersOccupation = value ?? "")),
                  _buildDropdownField(
                      'Brothers',
                      _brothers,
                      brothersOccupations,
                          (value) => setState(() => _brothers = value ?? "")),
                  _buildDropdownField(
                      'Sisters',
                      _sisters,
                      sistersOccupations,
                          (value) => setState(() => _sisters = value ?? "")),
                  const SizedBox(height: 10.0),
                  _buildSectionTitle('Education & Employment'),
                  const SizedBox(height: 10.0),
                  _buildDropdownField(
                      'Education',
                      _education,
                      educations,
                          (value) => setState(() => _education = value ?? "")),
                  _buildDropdownField(
                      'Occupation',
                      _profession,
                      occupations,
                          (value) => setState(() => _profession = value ?? "")),
                  const SizedBox(height: 20.0),
                  _buildSectionTitle('Astrological Details'),
                  const SizedBox(height: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: manglikOptions.map((option) {
                      return Row(
                        children: [
                          Radio<String>(
                            value: option,
                            groupValue: _manglik,
                            onChanged: (value) {
                              setState(() {
                                _manglik = value ?? "";
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
                  const SizedBox(height: 10.0),
                  _buildSectionTitle('Password'),
                  const SizedBox(height: 10.0),
                  _buildTextField('Password', _passWord,
                          (value) => setState(() => _passWord = value)),

                  // --- INCREASED BOTTOM SPACING ---
                  SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                        right: 12.0,
                        top: 16.0,
                        bottom: 60.0, // <-- Increased to 60.0 for extra bottom clearance
                      ),
                      child: PinkButton(
                        text: 'Save',
                        onTap: () {
                          if (isRemoveProfile) {
                            Get.snackbar(
                              'Error',
                              'Please select your first photo',
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white,
                            );
                            return;
                          }
                          if (_phoneNumber.trim().isEmpty ||
                              _phoneNumber.length < 8) {
                            Get.snackbar(
                              'Error',
                              'Please enter your phone number',
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white,
                            );
                            return;
                          }

                          editUserController.editUser(
                              _fName,
                              "$_birthHour:$_birthMinute$_birthM",
                              _email,
                              _phoneNumber,
                              _gender,
                              _day,
                              _month,
                              _year,
                              _motherTongue,
                              _religion,
                              _caste,
                              dataController.selectedCountry.value == null
                                  ? _country
                                  : dataController
                                  .selectedCountry.value!.dataName,
                              dataController.selectedState.value == null
                                  ? _state
                                  : dataController.selectedState.value!.dataName,
                              dataController.selectedCity.value == null
                                  ? _city
                                  : dataController.selectedCity.value!.dataName,
                              _profileCreatedBy,
                              pickedImage2!,
                              pickedImage3!,
                              pickedImage4!,
                              _language,
                              _physicalStatus,
                              _medical,
                              _father,
                              _fathersOccupation,
                              _mother,
                              _mothersOccupation,
                              _brothers,
                              _sisters,
                              _height,
                              _education,
                              _employed,
                              _complexion,
                              _profession,
                              _music,
                              _sports,
                              _movies,
                              _maritalStatus,
                              _outfit,
                              _about,
                              _annualIncome,
                              _smoking,
                              _drinking,
                              parse(_eating).body!.text,
                              _selectedAge ?? widget.userDetail.age,
                              _familyType,
                              _bodyType,
                              parse(_manglik).body!.text,
                              _familyStatus,
                              _birthPlace,
                              _passWord);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePickerBox(int index, Uint8List? bytes, String networkUrl) {
    ImageProvider? imageProvider;
    if (bytes != null) {
      imageProvider = MemoryImage(bytes);
    } else if (networkUrl.isNotEmpty) {
      imageProvider = NetworkImage(networkUrl);
    }

    return GestureDetector(
      onTap: () async {
        await photoPickerController.pickImage(index);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 70,
          height: 60,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            color: const Color.fromARGB(255, 222, 220, 220),
            image: imageProvider != null
                ? DecorationImage(image: imageProvider, fit: BoxFit.cover)
                : null,
          ),
          child: imageProvider == null
              ? Center(
            child: Text(
              'Add Photo $index',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10),
            ),
          )
              : null,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, String initialValue, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onChanged: onChanged,
      ),
    );
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
          value: items.contains(selectedItem.value) ? selectedItem.value : null,
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
        );
      }),
    );
  }

  Widget birthDateWidget() {
    return Row(
      children: [
        Expanded(
          child: _buildDropdownField(
            'Date',
            _day,
            days,
                (value) => setState(() => _day = value ?? ""),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: _buildDropdownField(
            'Month',
            _month,
            months,
                (value) => setState(() => _month = value ?? ""),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: _buildDropdownField(
            'Year',
            _year,
            years,
                (value) => setState(() => _year = value ?? ""),
          ),
        ),
      ],
    );
  }

  Widget birthTimeWidget() {
    return Row(
      children: [
        Expanded(
          child: _buildDropdownField(
            'Hour',
            _birthHour,
            hours,
                (value) => setState(() => _birthHour = value ?? ""),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: _buildDropdownField(
            'Minutes',
            _birthMinute,
            minutes,
                (value) => setState(() => _birthMinute = value ?? ""),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: _buildDropdownField(
            'Time',
            _birthM,
            time,
                (value) => setState(() => _birthM = value ?? ""),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(
      String label,
      String? currentValue,
      List<String> items,
      ValueChanged<String?> onChanged,
      ) {
    final isValidValue = items.contains(currentValue);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        isDense: true,
        value: isValidValue ? currentValue : null,
        hint: Text(currentValue?.isNotEmpty == true ? currentValue! : 'Select $label'),
        decoration: InputDecoration(
          labelText: label,
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
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
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
        value: items.contains(selectedItem.value) ? selectedItem.value : null,
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

String cleanText(String text) {
  return text
      .replaceAll("&#039;", "'")
      .replaceAll("&amp;", "&")
      .replaceAll("&quot;", "\"")
      .replaceAll("&lt;", "<")
      .replaceAll("&gt;", ">");
}