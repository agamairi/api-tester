// test/api_tester_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:api_tester/models/request_model.dart';
import 'package:api_tester/models/response_model.dart';
import 'package:api_tester/services/api_service.dart';

void main() {
  group('ApiService', () {
    test('GET request returns 200', () async {
      final request = RequestModel(
        method: 'GET',
        url: 'http://localhost:3000/hello',
      );

      final response = await ApiService.send(request);
      expect(response.statusCode, 200);
      expect(response.body.contains('Hello'), true);
    });

    test('POST request echoes back data', () async {
      final request = RequestModel(
        method: 'POST',
        url: 'http://localhost:3000/echo',
        contentType: 'application/json',
        body: '{"message": "Hi"}',
      );

      final response = await ApiService.send(request);
      expect(response.statusCode, 200);
      expect(response.body.contains('Hi'), true);
    });
  });
}
