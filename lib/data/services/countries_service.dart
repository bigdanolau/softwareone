// Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Project imports:
import 'package:softwareone/data/models/countries_model.dart';
import 'package:softwareone/data/models/token_model.dart';

class CountriesService {
  final Dio client;

  CountriesService(this.client);

  Future<List<CountriesModel>> getCountries(TokenModel? token) async {
    try {
      final Map<String, String> headers = {
        'Authorization': 'Bearer ${token?.authToken}',
        'api-token': dotenv.get('API_TOKEN'),
        'Accept': 'application/json',
      };
      final response = await client.get<dynamic>(
          '${dotenv.get('API_URL')}/countries/',
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        final parsed = response.data;
        final List<CountriesModel> listCountries = parsed.map<CountriesModel>(
          (dynamic json) {
            return CountriesModel.fromJson(json);
          },
        ).toList();
        return listCountries;
      } else if (response.statusCode == 502) {
        throw Exception('token expired');
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      return [];
    }
  }
}
