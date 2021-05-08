import 'Task.dart';
import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _taskList = [];

  List<TaskModel> get getTaskList => _taskList;

  String get getCurrentMonth => '${DateTime.now().year.toString()}년 ${DateTime.now().month.toString().padLeft(2,'0')}월';

  int getMonthMoney() {
    int total = 0;
    _taskList.forEach((element) {
      if (element.getMonth() == getCurrentMonth) {
        switch(element.getTaskState()) {
          case '+':
            total += int.parse(element.getContent());
            break;
          case '-':
            total -= int.parse(element.getContent());
            break;
        }
      }
    });
    return total;
  }

  void addTask(String title, String content, DateTime date, TaskState _integer) {
    TaskModel newTask = TaskModel(title, content, date, _integer);
    _taskList.add(newTask);
    notifyListeners();
  }
}
