import 'package:rxdart/rxdart.dart';
import 'package:todo_app/model/usersModel.dart';
import 'package:todo_app/resources/repoUsers.dart';

class UserBloc {
  final RepoUsers _repositoryUsers = RepoUsers();

  final PublishSubject<List<UsersModel>> _userFetcher =
      PublishSubject<List<UsersModel>>();

  Stream<List<UsersModel>> get allUsers => _userFetcher.stream;

  UserBloc() {
    getAllUsers();
  }

  getAllUsers() async {
    List<UsersModel> user = await _repositoryUsers.getAllUsers();
    _userFetcher.sink.add(user);
  }

  getUser(String email, String pass) async {
    await _repositoryUsers.getUser(email, pass);
  }

  addTodo(UsersModel todo) async {
    await _repositoryUsers.insertTodo(todo);
    getAllUsers();
  }
}

final userBloc = UserBloc();
