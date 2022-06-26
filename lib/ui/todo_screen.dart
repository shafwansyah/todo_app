import 'package:flutter/material.dart';
import 'package:todo_app/blocs/todo_bloc.dart';
import 'package:todo_app/model/todoModel.dart';
import 'package:todo_app/ui/addTask.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    todoBloc.getAllTodos();

    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO List'),
      ),
      body: StreamBuilder<List<todoModel>>(
        stream: todoBloc.allTodos,
        builder: (context, AsyncSnapshot<List<todoModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data![index].desc.toString(),
                        style: TextStyle(
                          decoration: snapshot.data![index].is_done!
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      Text(
                        snapshot.data![index].due_date.toString(),
                        style: TextStyle(
                          decoration: snapshot.data![index].is_done!
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  subtitle: const Text("Click to delete"),
                  onTap: () {
                    todoBloc.deleteTodo(snapshot.data![index].id!.toInt());
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.data == null) {
            return const Center(
              child: Text('Create First Todo'),
            );
          }
          return const Center(child: CircularProgressIndicator());
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
