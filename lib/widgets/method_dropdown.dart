// lib/widgets/method_dropdown.dart
import 'package:flutter/material.dart';

class MethodDropdown extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;
  final List<String> methods = const [
    'GET',
    'POST',
    'PUT',
    'DELETE',
    'PATCH',
    'HEAD',
  ];

  const MethodDropdown({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selected,
      decoration: const InputDecoration(labelText: 'Method'),
      onChanged: (value) => onChanged(value!),
      items: methods
          .map((m) => DropdownMenuItem(value: m, child: Text(m)))
          .toList(),
    );
  }
}
