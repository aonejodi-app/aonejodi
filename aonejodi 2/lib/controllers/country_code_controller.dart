import 'package:get/get.dart';
import 'package:app/models/form-models/form-data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryCodeController extends GetxController {
  // List of countries
  final RxList<CountryDataModel> countriesCode = <CountryDataModel>[].obs;

  // Selected country
  var selectedCountryCode = Rxn<CountryDataModel>(); // <-- must be Rxn<CountryDataModel>

  @override
  void onInit() {
    super.onInit();
    fetchCountriesCode();
  }

  Future<void> fetchCountriesCode() async {
    final uri =
    Uri.parse('https://superjodi.in/API/index.php?p=getcountries_list');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> countriesList = responseData['msg'];
        countriesCode.value = countriesList
            .map((item) => CountryDataModel(
          dataName: item['name'],
          dataId: item['id'].toString(),
          phoneCode: item['phonecode'],
          shortName: item['sortname'],
        ))
            .toList();

        // Optional: preselect the second item automatically
        if (countriesCode.length > 1) {
          selectedCountryCode.value = countriesCode[1];
        }
      } else {
        print('Failed to load countries');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
