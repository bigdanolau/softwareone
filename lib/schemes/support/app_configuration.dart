enum Enviroment {
  localhost,
  development,
  staging,
  production,
}

mixin AppConfiguration {
  static const Enviroment enviroment = Enviroment.development;
  static const apiUrl =
      'https://www.universal-tutorial.com/rest-apis/free-rest-api-for-country-state-city';
  static const bool isDebug = true;
}
