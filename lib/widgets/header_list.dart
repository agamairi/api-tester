// lib/widgets/header_list.dart
import 'package:flutter/material.dart';

class HeaderList extends StatefulWidget {
  final Map<String, String> headers;
  final VoidCallback onChanged;

  const HeaderList({super.key, required this.headers, required this.onChanged});

  @override
  State<HeaderList> createState() => _HeaderListState();
}

class _HeaderListState extends State<HeaderList> {
  final _keyController = TextEditingController();
  final _valueController = TextEditingController();

  void _addHeader() {
    final k = _keyController.text.trim();
    final v = _valueController.text.trim();
    if (k.isNotEmpty && v.isNotEmpty) {
      setState(() {
        widget.headers[k] = v;
        _keyController.clear();
        _valueController.clear();
        widget.onChanged();
      });
    }
  }

  void _removeHeader(String key) {
    setState(() {
      widget.headers.remove(key);
      widget.onChanged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Headers", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...widget.headers.entries.map(
          (e) => ListTile(
            dense: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
            title: Text('${e.key}: ${e.value}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _removeHeader(e.key),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _keyController,
                decoration: const InputDecoration(
                  hintText: 'Header Key',
                  filled: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _valueController,
                decoration: const InputDecoration(
                  hintText: 'Header Value',
                  filled: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.green),
              onPressed: _addHeader,
            ),
          ],
        ),
      ],
    );
  }
}
