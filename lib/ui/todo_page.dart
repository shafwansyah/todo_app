import 'package:flutter/material.dart';
import 'package:todo_app/api/notification_api.dart';
import 'package:todo_app/blocs/todo_bloc.dart';
import 'package:todo_app/model/todoModel.dart';
import 'package:todo_app/ui/login_page.dart';

import 'addTask.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  String? desc;
  DateTime? due_date;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    NotificationApi.showScheduledNotification(
      title: "Do Your Task",
      body: desc,
      scheduledDate: DateTime.now().add(Duration(seconds: 12)),
    );

    NotificationApi.init(initSchedule: true);
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ));

  @override
  Widget build(BuildContext context) {
    todoBloc.getAllTodos();

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: StreamBuilder<List<todoModel>>(
        stream: todoBloc.allTodos,
        builder: (context, AsyncSnapshot<List<todoModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data![index].desc.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            snapshot.data![index].due_date.toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      TextButton.icon(
                        onPressed: () {
                          todoBloc
                              .deleteTodo(snapshot.data![index].id!.toInt());
                        },
                        icon: Icon(Icons.delete_outline),
                        label: Text('Delete'),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          primary: Colors.white,
                        ),
                      )
                    ],
                  ),
                ));
              },
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.data == null) {
            return const Center(
              child: Text('Create First Todo'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return AddTask();
              });
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
