import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/api_client/todo_api_client.dart';
import 'package:todos_data/todos_data.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial()) {
    _getInitialTodos();
  }

  late final apiClient = TodoAPIClient();

  void _getInitialTodos() async {
    final todos = await apiClient.readAll();
    emit(
      Todos(todos.toSet()),
    );
  }

  @override
  void onChange(Change<TodoState> change) {
    print(change);
    super.onChange(change);
  }

  void addTodo(String task) {
    _addTodo(
      Todo(
        title: task,
        description: task,
        isCompleted: false,
      ),
    );
  }

  void _addTodo(Todo task) async {
    task = await apiClient.create(task);
    state.todos.add(task);
    emit(Todos(state.todos));
  }

  void done(Todo task) async {

    final doneTask = state.todos
        .firstWhere((element) => element == task)
        .copyWith(isCompleted: true);


    await apiClient.update(doneTask.id!, doneTask);


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

  }
}
