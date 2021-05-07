import 'package:exchange_budget_flutter/Task.dart';
import 'package:exchange_budget_flutter/CustomDialog.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: TaskPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class TaskPage extends StatefulWidget {
  TaskPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<TaskModel> _taskList = [];

  TaskState _integer = TaskState.PLUS;
  final nameController = TextEditingController();

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "가계부 입력",
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile(
                  title: Text("수입"),
                  value: TaskState.PLUS,
                  groupValue: _integer,
                  onChanged: (value) {
                    setState(() {
                      _integer = value;
                    });
                  },
                ),
                RadioListTile(
                  title: Text("지출"),
                  value: TaskState.MINUS,
                  groupValue: _integer,
                  onChanged: (value) {
                    setState(() {
                      _integer = value;
                    });
                  },
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '내역',
                  ),
                )
              ],
            ),
            actions: [
              TextButton(
                child: Text("Close"),
                onPressed: () {
                  _addNewTask(nameController.text, _integer);
                  nameController.text = "";
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void _addNewTask(String title, TaskState _integer) {
    TaskModel newTask = TaskModel(title, _integer);
    setState(() {
      _taskList.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: _createTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _createTodoList() {
    return ListView.separated(
      itemCount: _taskList.length,
      itemBuilder: (BuildContext context, int index) {
        return _createTodoCard(_taskList[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          thickness: 8.0,
          height: 8.0,
          color: Colors.transparent,
        );
      },
    );
  }

  Widget _createTodoCard(TaskModel todoModel) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
          padding: EdgeInsets.all(16.0), child: _createTodoItemRow(todoModel)),
    );
  }

  Widget _createTodoItemRow(TaskModel todoModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _createTodoItemContentWidget(todoModel),
        Icon(Icons.keyboard_arrow_right, color: Colors.blue)
      ],
    );
  }

  Widget _createTodoItemContentWidget(TaskModel todoModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(todoModel.getTitle(),
            style: TextStyle(fontSize: 24.0, color: Colors.blue)),
        Divider(
          thickness: 8.0,
          height: 8.0,
          color: Colors.transparent,
        ),
      ],
    );
  }
}
