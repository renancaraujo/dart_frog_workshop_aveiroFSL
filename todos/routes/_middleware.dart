import 'package:dart_frog/dart_frog.dart';
import 'package:todos/todos.dart';


final _dataSource = MemmoryTodosDataSource();

Handler middleware(Handler handler) {
  handler.use(provider<TodosDataSource>((_)=>_dataSource));
  return handler;
}
