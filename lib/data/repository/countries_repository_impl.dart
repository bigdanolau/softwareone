// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:softwareone/data/models/countries_model.dart';
import 'package:softwareone/data/models/token_model.dart';
import 'package:softwareone/data/services/api_service.dart';
import 'package:softwareone/data/services/countries_service.dart';
import 'package:softwareone/domain/repository/countries_repository.dart';

class CountriesRepositoryImpl extends CountriesRepository {
  final ApiService apiService = ApiService(
    Dio(),
  );
  final CountriesService countriesService = CountriesService(
    Dio(),
  );

  CountriesRepositoryImpl();
  @override
  Future<List<CountriesModel>> getCountries(TokenModel token) async {
    try {
      final List<CountriesModel> countries =
          await countriesService.getCountries(token);
      return countries;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<TokenModel?> getToken() async {
    try {
      final TokenModel? token = await apiService.getToken();
      return token;
    } catch (e) {
      return null;
    }
  }
}
