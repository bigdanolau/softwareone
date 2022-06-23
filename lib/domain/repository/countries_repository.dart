import 'package:softwareone/data/models/countries_model.dart';
import 'package:softwareone/data/models/token_model.dart';

abstract class CountiesRepository {
  Future<CountriesModel?> getCities(TokenModel token);
  Future<TokenModel?> getToken();
}
