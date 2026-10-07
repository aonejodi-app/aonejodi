import 'package:app/models/form-models/form-data.dart';
import 'package:app/views/options.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataController extends GetxController {
  final RxList<DataModel> religions = <DataModel>[].obs;
  final RxList<DataModel> caste = <DataModel>[].obs;
  final RxList<CountryDataModel> countries = <CountryDataModel>[].obs;

  final RxList<DataModel> states = <DataModel>[].obs;
  final RxList<DataModel> cities = <DataModel>[].obs;
  final RxList<DataModel> languages = <DataModel>[].obs;

  var selectedReligion = Rxn<DataModel>();
  var selectedCaste = Rxn<DataModel>();
  var selectedCountry = Rxn<CountryDataModel>();

  var selectedState = Rxn<DataModel>();
  var selectedCity = Rxn<DataModel>();
  var selectedLanguage = Rxn<DataModel>();
  var aboutUs = "";
  var isLoading = false.obs;

  var email = "";
  var phone = "";
  var gst_number = "";
  var office_timing = "";
  var office_address = "";

  @override
  void onInit() {
    super.onInit();
    fetchReligions();
    fetchCountries();
    fetchLanguages();
  }

  void resetSelections() {
    selectedReligion.value = null;
    selectedCaste.value = null;
    selectedCountry.value = null;
    selectedState.value = null;
    selectedCity.value = null;
    selectedLanguage.value = null;
    caste.clear();
    states.clear();
    cities.clear();
  }

  // Fetch list of languages
  Future<void> fetchLanguages() async {
    final uri =
        Uri.parse('https://superjodi.in/API/index.php?p=getlanguage_list');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> languagesList = responseData['msg'];

        languages.assignAll(languagesList
            .map((item) => DataModel(
                  dataName: item['name'].toString(),
                  dataId: item['id'].toString(),
                ))
            .toList());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Fetch list of religions
  Future<void> fetchReligions() async {
    final uri =
        Uri.parse('https://superjodi.in/API/index.php?p=getreligion_list');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> religionsList = responseData['msg'];
        religions.assignAll(religionsList
            .map((item) => DataModel(
                  dataName: item['name'].toString(),
                  dataId: item['id'].toString(),
                ))
            .toList());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchAboutUs() async {
    isLoading(true);
    final uri = Uri.parse('https://superjodi.in/API/index.php?p=getaboutUs');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> msg = responseData['msg'];
        aboutUs = msg.isNotEmpty
            ? msg.first['description'].toString()
            : "No About Us content found.";
      }
    } catch (e) {
      aboutUs = "Error: $e";
    }
    isLoading(false);
  }

  Future<void> fetchTermsConditions() async {
    isLoading(true);
    final uri =
        Uri.parse('https://superjodi.in/API/index.php?p=getTermsAndCondition');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> msg = responseData['msg'];
        aboutUs = msg.isNotEmpty
            ? msg.first['description'].toString()
            : "No About Us content found.";
      }
    } catch (e) {
      aboutUs = "Error: $e";
    }
    isLoading(false);
  }

  Future<void> fetchPrivacyPolicy() async {
    isLoading(true);
    final uri =
        Uri.parse('https://superjodi.in/API/index.php?p=getPrivacyPolicy');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> msg = responseData['msg'];
        aboutUs = msg.isNotEmpty
            ? msg.first['description'].toString()
            : "No About Us content found.";
      }
    } catch (e) {
      aboutUs = "Error: $e";
    }
    isLoading(false);
  }

  Future<void> fetchContactInfo() async {
    isLoading(true);
    final uri = Uri.parse('https://superjodi.in/API/index.php?p=getContactInfo');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> msg = responseData['msg'];

        email = msg.isNotEmpty ? msg.first['email'].toString() : "";
        phone = msg.isNotEmpty ? msg.first['phone'].toString() : "";
        gst_number = msg.isNotEmpty ? msg.first['gst_number'].toString() : "";
        office_timing =
            msg.isNotEmpty ? msg.first['office_timing'].toString() : "";
        office_address =
            msg.isNotEmpty ? msg.first['office_address'].toString() : "";
      }
    } catch (e) {
      print(e);
    }
    isLoading(false);
  }

  // Fetch list of castes based on religion ID
  Future<void> fetchCastes(String religionId) async {
    final uri = Uri.parse('https://superjodi.in/API/index.php?p=getcast_list');
    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'religion_id': religionId}),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> castesList = responseData['msg'];
        caste.assignAll(castesList
            .map((item) => DataModel(
                  dataName: item['name'].toString(),
                  dataId: item['id'].toString(),
                ))
            .toList());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Fetch list of countries
  Future<void> fetchCountries() async {
    final uri =
        Uri.parse('https://superjodi.in/API/index.php?p=getcountries_list');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> countriesList = responseData['msg'];
        countries.assignAll(countriesList
            .map((item) => CountryDataModel(
                  dataName: item['name'].toString(),
                  dataId: item['id'].toString(),
                  phoneCode: item['phonecode'].toString(),
                  shortName: item['sortname'].toString(),
                ))
            .toList());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Fetch list of states based on country ID
  Future<void> fetchStates(String countryId) async {
    states.assignAll([]); // Clear list
    cities.assignAll([]); // Clear cities too
    final uri = Uri.parse('https://superjodi.in/API/index.php?p=getstates_list');
    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'country_id': countryId}),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> statesList = responseData['msg'];
        states.assignAll(statesList
            .map((item) => DataModel(
                  dataName: item['name'].toString(),
                  dataId: item['id'].toString(),
                ))
            .toList());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Fetch list of cities based on state ID
  Future<void> fetchCities(String stateId) async {
    final uri =
    Uri.parse('https://superjodi.in/API/index.php?p=getcities_list');
    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'state_id': stateId}),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> citiesList = responseData['msg'];
        cities.value = citiesList
            .map((item) => DataModel(
          dataName: item['name'],
          dataId: item['id'].toString(),
        ))
            .toList();
      } else {
        print('Failed to load cities');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
