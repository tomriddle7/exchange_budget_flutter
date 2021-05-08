import 'Task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

import 'TaskProvider.dart';

class CustomDialog extends StatefulWidget {
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  TaskState _integer = TaskState.PLUS;
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  var taskDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
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
            controller: titleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '내역',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: contentController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '금액',
            ),
          ),
          TextButton(
              onPressed: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2020, 1, 1),
                    maxTime: DateTime(2030, 12, 31),
                    theme: DatePickerTheme(
                        itemStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        doneStyle:
                            TextStyle(color: Colors.black, fontSize: 16)),
                    onConfirm: (date) {
                  print('confirm $date');
                  setState(() {
                    taskDate = date;
                  });
                }, currentTime: taskDate, locale: LocaleType.ko);
              },
              child: Text(
                '날짜: ${taskDate.year.toString()}년 ${taskDate.month.toString().padLeft(2,'0')}월 ${taskDate.day.toString().padLeft(2,'0')}일',
                style: TextStyle(color: Colors.black, fontSize: 20),
              )),
        ],
      ),
      actions: [
        TextButton(
          child: Text("추가"),
          onPressed: () {
            Provider.of<TaskProvider>(context, listen: false).addTask(
                titleController.text, contentController.text, taskDate, _integer);
            titleController.text = "";
            contentController.text = "";
            taskDate = DateTime.now();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
