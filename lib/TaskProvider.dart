import 'package:exchange_budget_flutter/Task.dart';
import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _taskList = [];

  List<TaskModel> get getTaskList => _taskList;

  void addTask(String title, TaskState _integer) {
    TaskModel newTask = TaskModel(title, _integer);
    _taskList.add(newTask);
    notifyListeners();
  }
}
