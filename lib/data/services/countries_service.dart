import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:softwareone/data/models/countries_model.dart';
import 'package:softwareone/data/models/token_model.dart';
import 'package:softwareone/domain/repository/countries_repository.dart';

class CountriesService {
  final Dio client;

  final CountiesRepository countriesRepository;

  CountriesService({
    required this.countriesRepository,
    required this.client,
  });

  Future<CountriesModel?> getCountries(TokenModel? token) async {
    try {
      final Map<String, String> headers = {
        'Authorization': 'Bearer ${token?.authToken}',
        'api-token': dotenv.get('API_TOKEN'),
        'Accept': 'application/json',
      };
      final response = await client.get<dynamic>(
          '${dotenv.get('API_URL')}/countries/',
          options: Options(headers: headers));
      final parsedData = CountriesModel.fromJson(response.data);

      return parsedData;
    } catch (e) {
      return null;
    }
  }
}
