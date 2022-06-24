// Project imports:
import 'package:softwareone/data/models/countries_model.dart';
import 'package:softwareone/data/models/token_model.dart';

abstract class CountriesRepository {
  Future<List<CountriesModel?>> getCountries(TokenModel token);
  Future<TokenModel?> getToken();
}
