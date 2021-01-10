import 'package:dio/dio.dart';
import 'package:todo_list/app/models/todo_model.dart';

class TodoRepository {
  Dio dio;
  final url = "https://jsonplaceholder.typicode.com/todos";

  TodoRepository({Dio dio}) : this.dio = dio ?? Dio();

  Future<List<TodoModel>> fetchTodos() async {
    final response = await dio.get(url);
    final list = response.data as List;

    return list.map((e) => TodoModel.fromJson(e)).toList();
  }
}
