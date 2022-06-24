// Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Project imports:
import 'package:softwareone/data/models/token_model.dart';

class ApiService {
  final Dio client;

  ApiService(this.client);

  Future<TokenModel?> getToken() async {
    try {
      final Map<String, String> headers = {
        'user-email': dotenv.get('USER_EMAIL'),
        'api-token': dotenv.get('API_TOKEN'),
        'Accept': 'application/json',
      };
      final response = await client.get<dynamic>(
          '${dotenv.get('API_URL')}/getaccesstoken',
          options: Options(headers: headers));
      final parsedData = TokenModel.fromJson(response.data);

      return parsedData;
    } catch (e) {
      return null;
    }
  }
}
