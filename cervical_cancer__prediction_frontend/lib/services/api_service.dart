import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/prediction_request.dart';
import '../models/prediction_response.dart';

class ApiService {
  static const String baseUrl =
      'https://cervical-cancer-prediction.onrender.com';
  static const String predictEndpoint = '/predict';

  // Predict cervical cancer risk
  Future<PredictionResponse> predictRisk(PredictionRequest request) async {
    try {
      final url = Uri.parse('$baseUrl$predictEndpoint');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return PredictionResponse.fromJson(data);
      } else if (response.statusCode == 422) {
        // Validation error
        throw ApiException(
          'Invalid input data. Please check all fields.',
          statusCode: 422,
        );
      } else if (response.statusCode == 500) {
        throw ApiException(
          'Server error. Please try again later.',
          statusCode: 500,
        );
      } else {
        throw ApiException(
          'Failed to get prediction. Status: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException catch (e) {
      throw ApiException(
        'Network error: ${e.message}. Please check your internet connection.',
      );
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException('Unexpected error: ${e.toString()}');
    }
  }

  // Health check (optional)
  Future<bool> checkApiHealth() async {
    try {
      final url = Uri.parse(baseUrl);
      final response = await http.get(url).timeout(const Duration(seconds: 10));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}

// Custom exception class for API errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => message;
}
