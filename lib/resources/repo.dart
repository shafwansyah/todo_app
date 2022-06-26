import 'package:todo_app/database/TodoController.dart';
import 'package:todo_app/model/todoModel.dart';

class Repo {
  final TodoController _dbController = TodoController();

  Future getAllTodos() => _dbController.getAllTodos();
  Future insertTodo(todoModel todo) => _dbController.createTODO(todo);
  Future updateTodo(todoModel todo) => _dbController.updateTodo(todo);
  Future deleteTodo(int i) => _dbController.deleteTodo(i);
}
