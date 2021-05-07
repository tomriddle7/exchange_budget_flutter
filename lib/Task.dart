class TaskModel {
  String _title;
  TaskState _state;

  TaskModel(this._title, this._state) {}

  String getTitle() => _title;
  TaskState getTaskState() => _state;
  String setTitle(String title) => _title = title;
  TaskState setTaskState(TaskState state) => _state = state;
}

enum TaskState { PLUS, MINUS }
