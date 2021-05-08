import 'Task.dart';
import 'CustomDialog.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'TaskProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: TaskPage(title: 'Provider Pattern Example')),
    );
  }
}

class TaskPage extends StatelessWidget {
  final String title;

  TaskPage({this.title});

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<TaskProvider>(context);
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
        title: Text(this.title),
      ),
      body: _createTodoList(task),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          showDialog(
              context: context,
              builder: (context) {
                return CustomDialog();
              }),
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _createTodoList(task) {
    return GroupedListView<dynamic, String>(
      elements: task.getTaskList,
      groupBy: (element) => element.getMonth().toString(),
      groupComparator: (value1, value2) => value2.compareTo(value1),
      itemComparator: (item1, item2) =>
          item1.getDate().compareTo(item2.getDate()),
      order: GroupedListOrder.DESC,
      useStickyGroupSeparators: true,
      groupSeparatorBuilder: (String value) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value,
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      itemBuilder: (c, element) {
        return Card(
          elevation: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              title: Text(element.getTitle()),
              trailing: Text('${element.getTaskState()}${element.getContent()}',
                  style: TextStyle(
                      fontSize: 24.0,
                      color: element.getTaskState() == '+'
                          ? Colors.green
                          : Colors.red)),
            ),
          ),
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
            style: TextStyle(fontSize: 24.0, color: Colors.black)),
        Text('${todoModel.getTaskState()}${todoModel.getContent()}',
            style: TextStyle(
                fontSize: 24.0,
                color: todoModel.getTaskState() == '+'
                    ? Colors.green
                    : Colors.red)),
        Divider(
          thickness: 8.0,
          height: 8.0,
          color: Colors.transparent,
        ),
      ],
    );
  }
}
