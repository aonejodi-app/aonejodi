import 'package:app/Theme/theme-colors.dart';
import 'package:app/controllers/search-controller.dart';
import 'package:app/views/components/custom-appbar.dart';
import 'package:app/views/components/custom-drawer.dart';
import 'package:app/views/components/custom-dropdown-input.dart';
import 'package:app/views/components/pink-button.dart';
import 'package:app/views/screens/search-matches-page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/controllers/auth-controller.dart';

import '../../controllers/data-controller.dart';
import '../../models/form-models/form-data.dart';
import '../options.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchUserController searchController = Get.put(SearchUserController());

  final _formKey = GlobalKey<FormState>();

  String? _lookingForA;
  String? _minAge;
  String? _maxAge;
  String? _selectedMaritalStatus;

  final DataController dataController = Get.put(DataController());
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Search Matches with your Community",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: blackColor),
              ),
              const SizedBox(height: 28.0),

              Visibility(
                visible: false,
                child: CustomDropdownField(
                  label: 'I\'m looking for a',
                  options: genders,
                  onChanged: (value) => setState(() => _lookingForA = value),
                  hint: 'Select Gender',
                ),
              ),

              const SizedBox(height: 6.0),
              Row(
                children: [
                  Expanded(
                    child: CustomDropdownField(
                      label: 'Min Age',
                      options: ages,
                      onChanged: (value) => setState(() => _minAge = value),
                      hint: 'Select Option',
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Text('To'),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: CustomDropdownField(
                      label: 'Max Age',
                      options: ages,
                      onChanged: (value) => setState(() => _maxAge = value),
                      hint: 'Select Option',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
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
                null, // No validation required
              ),
              const SizedBox(height: 6.0),
              _buildDropdownFieldAPI(
                'Mother Tongue',
                "Select Mother Tongue",
                dataController.languages,
                dataController.selectedLanguage,
                (value) {
                  dataController.selectedLanguage.value=null;
                  dataController.selectedLanguage.value = value;
                },
                null, // No validation required
              ),
              const SizedBox(height: 6.0),
              _buildDropdownField(
                  'Marital Status',
                  'Select marital status',
                  maritalStatuses,
                  (value) => setState(() => _selectedMaritalStatus = value)),
              const SizedBox(height: 6.0),
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
                null, // No validation required
              ),
              const SizedBox(height: 20.0),
              PinkButton(
                text: 'Search Now',
                // onTap: () async {
                //   // Form validation is removed, so no validation checks here
                //   if (_formKey.currentState!.validate()) {
                //     if (_lookingForA == "" || _minAge == "" || _maxAge == "") {
                //       Get.snackbar('Please', 'Please select ');
                //     } else {
                //       await searchController.searchUser(
                //         _lookingForA ?? '',
                //         dataController.selectedReligion.value?.dataName ?? '',
                //         dataController.selectedLanguage.value?.dataName ?? '',
                //         _selectedMaritalStatus ?? '',
                //         dataController.selectedCountry.value?.dataName ?? '',
                //         _minAge?.replaceAll("yrs", '') ?? '',
                //         _maxAge?.replaceAll("yrs", '') ?? '',
                //       );
                //       Get.to(const SearchMatchPage());
                //     }
                //   }
                // },

                onTap: () async {
                  if (_formKey.currentState!.validate()) {

                    // 1. Get current gender and normalize it to lowercase for comparison
                    // String myGender = (dataController.userData.value?.gender ?? "male").toLowerCase();
                    String myGender = (authController.currentUser.value.gender ?? "male").toLowerCase();

                    // 2. Logic to flip the gender
                    // This ensures we send the EXACT string the backend expects

                    // String targetGender = (myGender == "male") ? "Female" : "Male";
                    String targetGender = (myGender == "male") ? "female" : "male";

                    // ^ Change "Female"/"Male" to "female"/"male" if your API is strictly lowercase

                    if (_minAge == null || _maxAge == null) {
                      Get.snackbar('Missing Info', 'Please select an age range');
                      return;
                    }

                    await searchController.searchUser(
                      // targetGender,
                      dataController.selectedReligion.value?.dataName ?? '',
                      dataController.selectedLanguage.value?.dataName ?? '',
                      _selectedMaritalStatus ?? '',
                      dataController.selectedCountry.value?.dataName ?? '',
                      _minAge?.replaceAll("yrs", '') ?? '',
                      _maxAge?.replaceAll("yrs", '') ?? '',
                    );

                    Get.to(const SearchMatchPage());
                  }
                },
              )
            ],
          ),
        ),
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
          validator: validator, // No validation needed here
        );
      }),
    );
  }

  Widget _buildDropdownField(
    String label,
    String hint,
    List<String> items,
    ValueChanged<String?> onChanged,
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

        // Validator is removed to make it non-mandatory
        validator: null,
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
        // validator: (value) {
        //   if (value == null) {
        //     return 'Please select your $label';
        //   }
        //   return null;
        // },
      );
    }),
  );
}
