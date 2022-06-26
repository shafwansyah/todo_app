import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'package:todo_app/api/notification_api.dart';
import 'package:todo_app/blocs/todo_bloc.dart';
import 'package:todo_app/model/todoModel.dart';

class AddTask extends StatefulWidget {
  AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late String taskName;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateTime dueDate = DateTime.now();
  String? expire;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Text(expire ?? 'Pick Date'),
          const SizedBox(
            height: 25.0,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: dueDate,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));

                    if (newDate == null) return;
                    setState(() {
                      dueDate = newDate;
                      expire = dateFormat.format(dueDate);
                    });
                  },
                  child: Text('Select Date'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: () {
                    // if (dueDate == DateTime.now()) {
                    //   Toast.show("at least choose tomorrow",
                    //       duration: Toast.lengthLong, gravity: Toast.bottom);
                    // }
                    todoBloc.addTodo(todoModel(
                      desc: taskName,
                      due_date: dateFormat.format(dueDate),
                      is_done: false,
                    ));

                    NotificationApi.showScheduledNotification(
                      title: "Do Your Task",
                      body: taskName,
                      scheduledDate:
                          DateTime.now().add(const Duration(seconds: 12)),
                    );

                    Navigator.pop(context);
                  },
                  child: Text('Add Task'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
