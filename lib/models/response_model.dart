// lib/models/request_model.dart
class RequestModel {
  String id;
  String method;
  String url;
  Map<String, String> headers;
  String body;
  String contentType;
  String authType; // 'None', 'Bearer', 'Basic', 'OAuth2'
  String token;
  DateTime timestamp;

  RequestModel({
    this.id = '',
    this.method = 'GET',
    this.url = '',
    Map<String, String>? headers,
    this.body = '',
    this.contentType = 'application/json',
    this.authType = 'None',
    this.token = '',
    DateTime? timestamp,
  }) : headers = headers ?? {},
       timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'id': id,
    'method': method,
    'url': url,
    'headers': headers,
    'body': body,
    'contentType': contentType,
    'authType': authType,
    'token': token,
    'timestamp': timestamp.toIso8601String(),
  };

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
    id: json['id'] ?? '',
    method: json['method'] ?? 'GET',
    url: json['url'] ?? '',
    headers: Map<String, String>.from(json['headers'] ?? {}),
    body: json['body'] ?? '',
    contentType: json['contentType'] ?? 'application/json',
    authType: json['authType'] ?? 'None',
    token: json['token'] ?? '',
    timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
  );
}
