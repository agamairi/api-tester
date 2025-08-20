// lib/screens/request_builder.dart
import 'package:api_tester/models/response_model.dart';
import 'package:api_tester/screens/response_viewer.dart';
import 'package:api_tester/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/method_dropdown.dart';
import '../widgets/header_list.dart';
import '../widgets/body_input.dart';
import '../models/request_model.dart';
import '../services/api_service.dart';
import '../state/app_state.dart';

class RequestBuilder extends StatefulWidget {
  final RequestModel? initialRequest;

  const RequestBuilder({super.key, this.initialRequest});

  @override
  State<RequestBuilder> createState() => _RequestBuilderState();
}

class _RequestBuilderState extends State<RequestBuilder> {
  late RequestModel _request; // ✅ use late
  ResponseModel? _response;

  final TextEditingController _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // ✅ If we got an initialRequest, clone it, otherwise start fresh
    _request = widget.initialRequest != null
        ? RequestModel(
            method: widget.initialRequest!.method,
            url: widget.initialRequest!.url,
            headers: Map.from(widget.initialRequest!.headers),
            body: widget.initialRequest!.body,
          )
        : RequestModel();

    _urlController.text = _request.url; // prefill URL
  }

  @override
  Widget build(BuildContext context) {
    final spacing = const SizedBox(height: 16);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.initialRequest == null ? "New Request" : "Edit Request",
          ), // ✅ dynamic title
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Method + URL in a row
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: MethodDropdown(
                      selected: _request.method,
                      onChanged: (m) => setState(() => _request.method = m),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 5,
                    child: TextField(
                      controller: _urlController,
                      decoration: const InputDecoration(
                        labelText: 'URL',
                        hintText: 'https://api.example.com/endpoint',
                        filled: true,
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (u) => _request.url = u,
                    ),
                  ),
                ],
              ),
              spacing,
              Expanded(
                child: ListView(
                  children: [
                    Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: HeaderList(
                          headers: _request.headers,
                          onChanged: () => setState(() {}),
                        ),
                      ),
                    ),
                    spacing,
                    Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: BodyInput(
                          model: _request,
                          onChanged: () => setState(() {}),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              spacing,
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _sendRequest,
                  icon: const Icon(Icons.send),
                  label: const Text('Send Request'),
                ),
              ),
              if (_response != null) ...[
                spacing,
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: ResponseViewer(response: _response!),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendRequest() async {
    final state = context.read<AppState>();

    if (_request.url.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter a valid URL")));
      return;
    }

    try {
      final expandedRequest = RequestModel(
        method: _request.method,
        url: state.expandVariables(_request.url),
        headers: _request.headers.map(
          (k, v) =>
              MapEntry(state.expandVariables(k), state.expandVariables(v)),
        ),
        body: state.expandVariables(_request.body),
      );

      final res = await ApiService.send(expandedRequest);
      setState(() => _response = res);
      await DbService.saveHistory(expandedRequest, res);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }
}
