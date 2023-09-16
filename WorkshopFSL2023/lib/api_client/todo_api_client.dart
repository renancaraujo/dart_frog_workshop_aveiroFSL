import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:todos_data/todos_data.dart';

const _baseUrl = 'http://localhost:8080';

abstract interface class TodosDataSource {
  Future<Todo> create(Todo todo);

  Future<List<Todo>> readAll();

  Future<Todo?> read(String id);

  Future<Todo> update(String id, Todo todo);

  Future<void> delete(String id);
}

class TodoAPIClient implements TodosDataSource {
  Uri get todosEndoint {
    return Uri.parse('$_baseUrl/todos');
  }

  Uri todosIdEndoint(String id) {
    return Uri.parse('$_baseUrl/todos/${id}');
  }

  @override
  Future<Todo> create(Todo todo) async {
    final jsonRequest = todo.toJson();
    final response = await post(
      todosEndoint,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(jsonRequest),
    );

    response.checkResponseOk();

    final jsonResponse = jsonDecode(response.body);

    final returnedTodo = Todo.fromJson(jsonResponse as Map<String, dynamic>);

    return returnedTodo;
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Todo?> read(String id) async {
    final response = await get(
      todosIdEndoint(id),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    response.checkResponseOk();

    final jsonResponse = jsonDecode(response.body);

    final returnedTodo = Todo.fromJson(jsonResponse as Map<String, dynamic>);

    return returnedTodo;
  }

  @override
  Future<List<Todo>> readAll() async {
    final response = await get(todosEndoint);

    response.checkResponseOk();

    final jsonResponse = jsonDecode(response.body) as List<dynamic>;

    final todos = jsonResponse
        .map((e) => Todo.fromJson(e as Map<String, dynamic>))
        .toList();

    return todos;
  }

  @override
  Future<Todo> update(String id, Todo todo) async {
    final jsonRequest = todo.toJson();
    final response = await put(
      todosIdEndoint(id),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(jsonRequest),
    );

    response.checkResponseOk();

    final jsonResponse = jsonDecode(response.body);

    final returnedTodo = Todo.fromJson(jsonResponse as Map<String, dynamic>);

    return returnedTodo;
  }
}

extension on Response {
  void checkResponseOk() {
    if (statusCode < 200 && statusCode > 299) {
      throw Exception("Oopsie, API response had status $statusCode");
    }
  }
}
