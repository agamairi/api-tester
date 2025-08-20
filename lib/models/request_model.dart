// lib/models/response_model.dart
class ResponseModel {
  int statusCode;
  Map<String, String> headers;
  String body;
  Duration duration;

  ResponseModel({
    required this.statusCode,
    required this.headers,
    required this.body,
    required this.duration,
  });

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'headers': headers,
    'body': body,
    'duration': duration.inMilliseconds,
  };

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    statusCode: json['statusCode'] ?? 0,
    headers: Map<String, String>.from(json['headers'] ?? {}),
    body: json['body'] ?? '',
    duration: Duration(milliseconds: json['duration'] ?? 0),
  );
}
