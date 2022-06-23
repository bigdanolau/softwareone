import 'package:softwareone/data/models/countries_model.dart';
import 'package:softwareone/data/models/token_model.dart';
import 'package:softwareone/data/services/api_service.dart';
import 'package:softwareone/data/services/countries_service.dart';
import 'package:softwareone/domain/repository/countries_repository.dart';

class CountriesRepositoryImpl extends CountiesRepository {
  final ApiService apiService;
  final CountriesService countriesService;

  CountriesRepositoryImpl(
    this.apiService,
    this.countriesService,
  );
  @override
  Future<CountriesModel?> getCities(TokenModel token) async {
    try {
      final CountriesModel? countries =
          await countriesService.getCountries(token);
      return countries;
    } catch (e) {
      return null;
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
