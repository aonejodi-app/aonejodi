class DataModel {
  final String dataName;
  final String dataId;

  DataModel({required this.dataName, required this.dataId});
}

class CountryDataModel {
  final String dataName;
  final String dataId;
  final String phoneCode;
  final String shortName;

  CountryDataModel(
      {required this.dataName,
        required this.dataId,
        required this.phoneCode,
        required this.shortName});
}
