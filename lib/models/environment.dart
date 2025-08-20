// lib/models/environment.dart
class Environment {
  String name;
  Map<String, String> variables;

  Environment({required this.name, Map<String, String>? variables})
    : variables = variables ?? {};

  Map<String, dynamic> toJson() => {'name': name, 'variables': variables};

  factory Environment.fromJson(Map<String, dynamic> json) => Environment(
    name: json['name'] ?? '',
    variables: Map<String, String>.from(json['variables'] ?? {}),
  );
}
