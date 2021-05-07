import 'package:exchange_budget_flutter/Task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'TaskProvider.dart';

class CustomDialog extends StatefulWidget {
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  TaskState _integer = TaskState.PLUS;
  final nameController = TextEditingController();

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
            Provider.of<TaskProvider>(context, listen: false)
                .addTask(nameController.text, _integer);
            nameController.text = "";
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
