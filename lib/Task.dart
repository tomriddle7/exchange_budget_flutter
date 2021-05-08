class TaskModel {
  String _title;
  String _content;
  DateTime _date;
  TaskState _state;

  TaskModel(this._title, this._content, this._date, this._state) {}

  String getTitle() => _title;
  String getContent() => _content;
  DateTime getDate() => _date;
  String getMonth() => '${_date.year.toString()}-${_date.month.toString().padLeft(2,'0')}';
  String getTaskState() => _state == TaskState.PLUS ? '+' : '-';
  String setTitle(String title) => _title = title;
  String setContent(String content) => _content = content;
  DateTime setDate(DateTime date) => _date = date;
  TaskState setTaskState(TaskState state) => _state = state;
}

enum TaskState { PLUS, MINUS }
