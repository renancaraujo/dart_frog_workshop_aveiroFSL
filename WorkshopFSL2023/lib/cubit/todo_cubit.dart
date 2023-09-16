import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/models/todo.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  @override
  void onChange(Change<TodoState> change) {
    print(change);
    super.onChange(change);
  }

  void addTodo(String task) {
    _addTodo(Todo(task, false));
  }

  void _addTodo(Todo task) {
    state.todos.add(task);
    emit(Todos(state.todos));
  }

  void done(Todo task) {
    final doneTask = state.todos
        .firstWhere((element) => element == task)
        .copyWith(done: true);

    print('Starting');
    print(state.todos.length);
    state.remove(task);
    print(state.todos.length);
    state.add(doneTask);
    print(state.todos.length);
    print('Done');

    emit(Todos(state.todos));
  }

  void unfinished(Todo task) {
    /// Rever the task so its not done.
    UnimplementedError('Not implemented');
  }
}
