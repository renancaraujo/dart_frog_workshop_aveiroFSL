import 'package:todos_data/todos_data.dart';
import 'package:uuid/uuid.dart';

abstract interface class TodoDataSource {
  Future<Todo> create(Todo todo);

  Future<List<Todo>> readAll();

  Future<Todo?> read(String id);

  Future<Todo> update(String id, Todo todo);

  void delete(String id);
}

class MemmoryDataSource implements TodoDataSource {
  final _cache = <String, Todo>{};

  @override
  Future<Todo> create(Todo todo) async {
    final id = const Uuid().v4();
    final createdTodo = todo.copyWith(id: id);
    _cache[id] = createdTodo;
    return createdTodo;
  }

  @override
  Future<List<Todo>> readAll() async {
    return _cache.values.toList();
  }

  @override
  Future<Todo?> read(String id) async {
    return _cache[id];
  }

  @override
  Future<Todo> update(String id, Todo todo) async {
    return _cache.update(id, (value) => todo);
  }

  @override
  void delete(String id) => _cache.remove(id);
}
