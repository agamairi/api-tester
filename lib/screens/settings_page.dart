// lib/screens/settings_page.dart
import 'package:api_tester/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Settings"), centerTitle: true),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Theme controls
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: state.darkMode,
              onChanged: (v) => state.toggleDarkMode(v),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Theme Color',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  MaterialColorPicker(
                    selectedColor: state.themeColor,
                    onMainColorChange: (color) {
                      if (color != null) {
                        state.setThemeColor(color);
                      }
                    },
                    allowShades: false,
                  ),
                ],
              ),
            ),
            // Global Variables section
            const Text(
              "Global Variables",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...state.globalVars.entries.map((entry) {
              return Card(
                child: ListTile(
                  title: Text(entry.key),
                  subtitle: Text(entry.value),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showVarDialog(
                          context,
                          state,
                          entry.key,
                          entry.value,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => state.removeGlobalVar(entry.key),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 80),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showVarDialog(context, state),
          icon: const Icon(Icons.add),
          label: const Text("Add Variable"),
        ),
      ),
    );
  }

  void _showVarDialog(
    BuildContext context,
    AppState state, [
    String? key,
    String? value,
  ]) {
    final keyCtrl = TextEditingController(text: key);
    final valCtrl = TextEditingController(text: value);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(key == null ? "Add Variable" : "Edit Variable"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: keyCtrl,
              decoration: const InputDecoration(labelText: "Key"),
            ),
            TextField(
              controller: valCtrl,
              decoration: const InputDecoration(labelText: "Value"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (key == null) {
                state.addGlobalVar(keyCtrl.text.trim(), valCtrl.text.trim());
              } else {
                state.editGlobalVar(
                  key,
                  keyCtrl.text.trim(),
                  valCtrl.text.trim(),
                );
              }
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
