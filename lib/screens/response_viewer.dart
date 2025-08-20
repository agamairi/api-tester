// lib/screens/response_viewer.dart
import 'package:api_tester/models/request_model.dart';
import 'package:flutter/material.dart';
import '../widgets/json_viewer.dart';

class ResponseViewer extends StatefulWidget {
  final ResponseModel response;
  const ResponseViewer({super.key, required this.response});

  @override
  State<ResponseViewer> createState() => _ResponseViewerState();
}

class _ResponseViewerState extends State<ResponseViewer> {
  bool prettified = true;

  @override
  Widget build(BuildContext context) {
    final res = widget.response;
    if (res.statusCode == -1) {
      return Center(
        child: Card(
          color: Colors.red.shade100,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              res.body,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Status: ${res.statusCode}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('Duration: ${res.duration.inMilliseconds}ms'),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Response Body'),
            Row(
              children: [
                const Text('Raw'),
                Switch(
                  value: prettified,
                  onChanged: (v) => setState(() => prettified = v),
                ),
                const Text('Pretty'),
              ],
            ),
          ],
        ),
        const Divider(),
        SizedBox(
          height: 200,
          child: SingleChildScrollView(
            child: JsonViewer(jsonString: res.body, prettified: prettified),
          ),
        ),
      ],
    );
  }
}
