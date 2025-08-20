// inside api_service.dart
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/request_model.dart';
import '../models/response_model.dart';

class ApiService {
  static Future<ResponseModel> send(RequestModel request) async {
    try {
      final uri = Uri.parse(request.url);

      http.Response res;

      switch (request.method.toUpperCase()) {
        case 'GET':
          res = await http
              .get(uri, headers: request.headers)
              .timeout(const Duration(seconds: 10));
          break;
        case 'POST':
          res = await http
              .post(uri, headers: request.headers, body: request.body)
              .timeout(const Duration(seconds: 10));
          break;
        case 'PUT':
          res = await http
              .put(uri, headers: request.headers, body: request.body)
              .timeout(const Duration(seconds: 10));
          break;
        case 'DELETE':
          res = await http
              .delete(uri, headers: request.headers)
              .timeout(const Duration(seconds: 10));
          break;
        default:
          return ResponseModel(
            statusCode: -1,
            body: 'Unsupported method',
            headers: {},
            duration: Duration.zero,
          );
      }

      return ResponseModel(
        statusCode: res.statusCode,
        body: res.body,
        headers: res.headers,
        duration: Duration.zero, // TODO: record request time
      );
    } on FormatException {
      return ResponseModel(
        statusCode: -1,
        body: 'Invalid URL format',
        headers: {},
        duration: Duration.zero,
      );
    } on TimeoutException {
      return ResponseModel(
        statusCode: -1,
        body: 'Request timed out',
        headers: {},
        duration: Duration.zero,
      );
    } catch (e) {
      return ResponseModel(
        statusCode: -1,
        body: 'Unexpected error: $e',
        headers: {},
        duration: Duration.zero,
      );
    }
  }
}
