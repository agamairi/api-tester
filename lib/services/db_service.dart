// lib/services/db_service.dart
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/request_model.dart';
import '../models/response_model.dart';

class DbService {
  static Database? _db;

  static Future<void> init() async {
    final path = join(await getDatabasesPath(), 'api_tester.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE history (
            id TEXT PRIMARY KEY,
            request TEXT,
            response TEXT,
            timestamp TEXT
          )
        ''');
      },
    );
  }

  static Future<void> saveHistory(RequestModel req, ResponseModel res) async {
    if (_db == null) await init();
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    await _db!.insert('history', {
      'id': id,
      'request': jsonEncode(req.toJson()),
      'response': jsonEncode(res.toJson()),
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  static Future<List<Map<String, dynamic>>> getHistory() async {
    if (_db == null) await init();
    return await _db!.query('history', orderBy: 'timestamp DESC');
  }

  static Future<void> deleteHistory(String id) async {
    if (_db == null) await init();
    await _db!.delete('history', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> clearAllHistory() async {
    if (_db == null) await init();
    await _db!.delete('history');
  }
}
