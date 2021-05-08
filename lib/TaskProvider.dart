import 'Task.dart';
import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _taskList = [];

  List<TaskModel> get getTaskList => _taskList;

  void addTask(String title, String content, DateTime date, TaskState _integer) {
    TaskModel newTask = TaskModel(title, content, date, _integer);
    _taskList.add(newTask);
    notifyListeners();
  }
}
