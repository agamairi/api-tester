// lib/widgets/json_viewer.dart
import 'dart:convert';
import 'package:flutter/material.dart';

class JsonViewer extends StatelessWidget {
  final String jsonString;
  final bool prettified;

  const JsonViewer({
    super.key,
    required this.jsonString,
    required this.prettified,
  });

  @override
  Widget build(BuildContext context) {
    try {
      final decoded = json.decode(jsonString);
      final pretty = const JsonEncoder.withIndent('  ').convert(decoded);
      return SelectableText(prettified ? pretty : jsonString);
    } catch (_) {
      return SelectableText(jsonString);
    }
  }
}
