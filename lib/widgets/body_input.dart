// lib/widgets/body_input.dart
import 'package:api_tester/models/response_model.dart';
import 'package:flutter/material.dart';

class BodyInput extends StatefulWidget {
  final RequestModel model;
  final VoidCallback onChanged;

  const BodyInput({super.key, required this.model, required this.onChanged});

  @override
  State<BodyInput> createState() => _BodyInputState();
}

class _BodyInputState extends State<BodyInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.model.body);
  }

  @override
  void didUpdateWidget(covariant BodyInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model.body != oldWidget.model.body) {
      _controller.text = widget.model.body;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          value: widget.model.contentType,
          decoration: const InputDecoration(
            labelText: 'Content Type',
            filled: true,
            border: OutlineInputBorder(),
          ),
          onChanged: (v) {
            widget.model.contentType = v!;
            widget.onChanged();
          },
          items: const [
            DropdownMenuItem(value: 'application/json', child: Text('JSON')),
            DropdownMenuItem(
              value: 'application/x-www-form-urlencoded',
              child: Text('Form URL Encoded'),
            ),
            DropdownMenuItem(
              value: 'multipart/form-data',
              child: Text('Multipart Form'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextField(
          maxLines: 8,
          controller: _controller,
          onChanged: (v) {
            widget.model.body = v;
            widget.onChanged();
          },
          decoration: const InputDecoration(
            labelText: "Body",
            hintText: '{ "example": true }',
            border: OutlineInputBorder(),
            filled: true,
          ),
        ),
      ],
    );
  }
}
