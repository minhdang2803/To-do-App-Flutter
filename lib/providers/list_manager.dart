import 'package:flutter/material.dart';
import 'package:todoapp/database.dart';
import 'package:todoapp/models/models.dart';

class ListManager extends ChangeNotifier {
  final _database = DatabaseHelper.instance;

  Future<void> addTask(Task task) async {
    await _database.insertTask(task);
    notifyListeners();
  }

  Future<List<Task>> getTask() async {
    final db = await _database.getTask();
    notifyListeners();
    return db;
  }

  Future<void> deleteAll() async {
    await _database.deleteAllTask();
    notifyListeners();
  }
}
