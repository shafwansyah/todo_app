import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/blocs/todo_bloc.dart';
import 'package:todo_app/model/todoModel.dart';

class AddTask extends StatefulWidget {
  AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String? taskName;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateTime dueDate = DateTime.now();
  String? expire;

  dateToString(date) {
    setState(() {
      expire = dateFormat.format(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 10.0,
        ),
        TextField(
          decoration: const InputDecoration(
            hintText: "Enter Task",
          ),
          onChanged: (value) {
            setState(() {
              taskName = value;
            });
          },
        ),
        const SizedBox(
          height: 25.0,
        ),
        TextField(
          decoration: const InputDecoration(
            hintText: "Due Task",
          ),
          onChanged: (value) {
            setState(() {
              expire = value;
            });
          },
        ),
        const SizedBox(
          height: 25.0,
        ),
        ElevatedButton(
          onPressed: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: dueDate,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100));

            if (newDate == null) return;
            setState(() => dueDate = newDate);
          },
          child: Text('Select Date'),
        ),
        const SizedBox(
          height: 25.0,
        ),
        MaterialButton(
            child: Container(
              width: 200.0,
              height: 50.0,
              color: Colors.deepPurpleAccent,
              child: const Center(
                child: Text("add"),
              ),
            ),
            onPressed: () {
              todoBloc.addTodo(todoModel(
                desc: taskName,
                due_date: dateFormat.format(dueDate),
                is_done: false,
              ));

              Navigator.pop(context);
            }),
      ],
    );
  }
}
