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
            primarySwatch: Colors.purple,
          ),
          home: TaskPage(title: '이번달 가계부')),
    );
  }
}

class TaskPage extends StatelessWidget {
  final String title;

  TaskPage({this.title});

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        elevation: 0,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: CustomShapeClipper(),
                child: Container(
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.purple),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                    child: Row(
                      children: [
                        Text(
                          task.getCurrentMonth,
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      '${task.getMonthMoney().toString()}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: _createTodoList(task),
          ),
        ],
      ),
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
      ),
    );
  }

  Widget _createTodoList(task) {
    return GroupedListView<dynamic, String>(
      elements: task.getTaskList,
      groupBy: (element) => element.getMonth().toString(),
      groupComparator: (value1, value2) => value2.compareTo(value1),
      itemComparator: (item1, item2) =>
          item2.getDate().compareTo(item1.getDate()),
      order: GroupedListOrder.ASC,
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
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, 340.0 - 200);
    path.quadraticBezierTo(size.width / 2, 230, size.width, 340.0 - 200);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
