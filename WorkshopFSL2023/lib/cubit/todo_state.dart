part of 'todo_cubit.dart';

@immutable
sealed class TodoState {
  final Set<Todo> todos;

  const TodoState(this.todos);

  void add(Todo task) {
    todos.add(task);
  }

  void remove(Todo task) {
    todos.remove(task);
  }
}

final class TodoInitial extends TodoState {
  TodoInitial() : super({});
}

final class Todos extends TodoState {
  const Todos(super.todos);
}
