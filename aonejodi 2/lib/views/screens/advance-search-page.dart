import 'package:app/Theme/theme-colors.dart';
import 'package:app/controllers/adv-search-controller.dart';
import 'package:app/views/components/custom-appbar.dart';
import 'package:app/views/components/custom-drawer.dart';
import 'package:app/views/components/custom-dropdown-input.dart';
import 'package:app/views/components/pink-button.dart';
import 'package:app/views/screens/advance-match-page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/data-controller.dart';
import '../../models/form-models/form-data.dart';
import '../options.dart';

class AdvanceSearchPage extends StatefulWidget {
  const AdvanceSearchPage({super.key});

  @override
  State<AdvanceSearchPage> createState() => _AdvanceSearchPageState();
}

class _AdvanceSearchPageState extends State<AdvanceSearchPage> {
  final AdvantageSearchUserController advantageSearchUserController =
      Get.put(AdvantageSearchUserController());
  final _formKey = GlobalKey<FormState>();

  String? _minAge;
  String? _maxAge;
  String? _selectedMaritalStatus;

  final DataController dataController = Get.put(DataController());

  @override
  void initState() {
    super.initState();
    dataController.resetSelections();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              const Text(
                "Search Matches with your Community",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: blackColor,
                    height: 2),
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
                    dataController.fetchCastes(value.dataId);
                  }
                },
                null,
              ),
              const SizedBox(height: 6.0),
              _buildDropdownFieldAPI(
                'Caste',
                "Select Caste",
                dataController.caste,
                dataController.selectedCaste,
                (value) {
                  dataController.selectedCaste.value = value;
                },
                null,
                dependsOn: dataController.selectedReligion,
              ),
              const SizedBox(height: 6.0),
              _buildDropdownFieldAPI(
                'Mother Tongue',
                "Select Mother Tongue",
                dataController.languages,
                dataController.selectedLanguage,
                (value) {
                  dataController.selectedLanguage.value = value;
                },
                null,
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
                    dataController.fetchStates(value.dataId);
                  }
                },
                null,
              ),
              // _buildDropdownFieldAPI(
              //   'State',
              //   "Select State",
              //   dataController.states,
              //   dataController.selectedState,
              //   (value) {
              //     dataController.selectedState.value = value;
              //     dataController.selectedCity.value = null;
              //     if (value != null) {
              //       dataController.fetchCities(value.dataId);
              //     }
              //   },
              //   null,
              //   dependsOn: dataController.selectedCountry,
              // ),
              // _buildDropdownFieldAPI(
              //   'City',
              //   "Select City",
              //   dataController.cities,
              //   dataController.selectedCity,
              //   (value) {
              //     dataController.selectedCity.value = value;
              //   },
              //   null,
              //   dependsOn: dataController.selectedState,
              // ),
              _buildDropdownFieldAPI(
                'State',
                "Select State",
                dataController.states,
                dataController.selectedState,
                    (value) {
                  dataController.selectedState.value = value;
                  // Reset cities when state changes
                  dataController.selectedCity.value = null;
                  if (value != null) {
                    dataController.fetchCities(value.dataId);
                  }
                },
                null, // No validator here to make it optional
              ),
              _buildDropdownFieldAPI('City', "Select City ",
                  dataController.cities, dataController.selectedCity, (value) {
                    dataController.selectedCity.value = value;
                  }, null),

              const SizedBox(height: 20.0),
              PinkButton(
                text: 'Search Now',
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_minAge == null || _maxAge == null) {
                      Get.snackbar('Please', 'Please select age range');
                      return;
                    } else {
                      await advantageSearchUserController.advsearchUser(
                        dataController.selectedReligion.value?.dataName ?? '',
                        dataController.selectedLanguage.value?.dataName ?? '',
                        _selectedMaritalStatus ?? '',
                        dataController.selectedCountry.value?.dataName ?? '',
                        _minAge?.replaceAll("yrs", '') ?? '',
                        _maxAge?.replaceAll("yrs", '') ?? '',
                        dataController.selectedCaste.value?.dataName ?? '',
                        dataController.selectedState.value?.dataName ?? '',
                        dataController.selectedCity.value?.dataName ?? '',
                      );
                      Get.to(const AdvantageMatchPage());
                    }
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
    final FormFieldValidator<DataModel>? validator, {
    Rxn<dynamic>? dependsOn,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Obx(() {
        final bool isParentSelected =
            dependsOn == null || dependsOn.value != null;
        final bool hasItems = items.isNotEmpty;
        final bool isDisabled = !isParentSelected || !hasItems;

        // ✅ Find the matching item from the list using ID to handle instance mismatch correctly
        DataModel? currentValue;
        if (selectedItem.value != null) {
          try {
            currentValue = items.firstWhere(
                (element) => element.dataId == selectedItem.value!.dataId);
          } catch (e) {
            currentValue = null;
          }
        }

        // return DropdownButtonFormField<DataModel>(
        //   // ✅ Critical: Added Key to force rebuild when dependency changes
        //   isExpanded: true,
        //   isDense: true,
        //   hint: Text(isDisabled
        //       ? (!isParentSelected ? "Select $label dependency" : "Loading...")
        //       : hint),
        //   decoration: InputDecoration(
        //     labelText: label,
        //     border: OutlineInputBorder(
        //       borderSide: BorderSide(color: Colors.grey[300]!),
        //     ),
        //     enabledBorder: OutlineInputBorder(
        //       borderSide: BorderSide(color: Colors.grey[300]!),
        //     ),
        //     focusedBorder: OutlineInputBorder(
        //       borderSide: BorderSide(color: Colors.grey[300]!),
        //     ),
        //     floatingLabelBehavior: FloatingLabelBehavior.always,
        //     labelStyle: const TextStyle(fontSize: 20.0),
        //   ),
        //   value: currentValue,
        //   items: items
        //       .map((item) => DropdownMenuItem<DataModel>(
        //             value: item,
        //             child: Text(item.dataName),
        //           ))
        //       .toList(),
        //   onChanged: isDisabled
        //       ? null
        //       : (DataModel? newValue) {
        //           selectedItem.value = newValue;
        //           onChanged(newValue);
        //         },
        //   validator: validator,
        // );

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
      );
    }),
  );
}
