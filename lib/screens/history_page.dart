// lib/screens/history_page.dart
import 'dart:convert';
import 'package:api_tester/screens/request_builder.dart';
import 'package:flutter/material.dart';
import '../services/db_service.dart';
import '../models/request_model.dart';
import '../models/response_model.dart';
import 'response_viewer.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> history = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    history = await DbService.getHistory();
    setState(() {});
  }

  void _delete(String id) async {
    await DbService.deleteHistory(id);
    await _load();
  }

  void _openInNew(RequestModel req) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => RequestBuilder(
          initialRequest: req, // pass request to builder
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('History'), centerTitle: true),
        body: ListView.builder(
          itemCount: history.length,
          itemBuilder: (ctx, i) {
            final item = history[i];
            final req = RequestModel.fromJson(jsonDecode(item['request']));
            final res = ResponseModel.fromJson(jsonDecode(item['response']));

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              child: ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${req.method} - ${req.url}',
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.open_in_new),
                      tooltip: "Open in request builder",
                      onPressed: () => _openInNew(req),
                    ),
                  ],
                ),
                subtitle: Text(
                  item['timestamp'].toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                children: [
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Response Viewer
                        ResponseViewer(response: res),

                        const SizedBox(height: 8),

                        // Actions
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: () => _delete(item['id']),
                              icon: const Icon(Icons.delete_outline),
                              label: const Text('Delete'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
