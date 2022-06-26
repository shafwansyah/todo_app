import 'package:rxdart/rxdart.dart';
import 'package:todo_app/model/todoModel.dart';
import 'package:todo_app/resources/repo.dart';

class TODOBloc {
  final Repo _repository = Repo();

  final PublishSubject<List<todoModel>> _todoFetcher =
      PublishSubject<List<todoModel>>();

  Stream<List<todoModel>> get allTodos => _todoFetcher.stream;

  TODOBloc() {
    getAllTodos();
  }

  getAllTodos() async {
    List<todoModel> todo = await _repository.getAllTodos();
    _todoFetcher.sink.add(todo);
  }

  addTodo(todoModel todo) async {
    await _repository.insertTodo(todo);
    getAllTodos();
  }

  updateTodo(todoModel todo) async {
    await _repository.updateTodo(todo);
    getAllTodos();
  }

  deleteTodo(int id) async {
    await _repository.deleteTodo(id);
    getAllTodos();
  }
}

final todoBloc = TODOBloc();
