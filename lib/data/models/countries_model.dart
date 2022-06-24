// Dart imports:
import 'dart:convert';

List<CountriesModel> countriesModelFromJson(String str) =>
    List<CountriesModel>.from(json.decode(str).map(CountriesModel.fromJson));

class CountriesModel {
  CountriesModel({
    required this.countryName,
    required this.countryShortName,
    required this.countryPhoneCode,
  });

  String countryName;
  String countryShortName;
  int countryPhoneCode;

  factory CountriesModel.fromJson(Map<String, dynamic> json) => CountriesModel(
        countryName: json['country_name'],
        countryShortName: json['country_short_name'],
        countryPhoneCode: json['country_phone_code'],
      );
}
