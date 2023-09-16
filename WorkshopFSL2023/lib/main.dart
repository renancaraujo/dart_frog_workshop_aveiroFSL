import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/models/todo.dart';

void main() {
  runApp(const MainApp());
}

final todoCubit = TodoCubit();

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: TodoView(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  final TextEditingController input = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...todoCubit.state.todos
            .map(
              (element) => Row(
                children: [
                  Text(element.task),
                  if (element.isNotDone)
                    IconButton(
                      onPressed: () => _done(element),
                      icon: const Icon(Icons.done),
                    )
                ],
              ),
            )
            .toList(),
        TextField(
          controller: input,
          onSubmitted: _addTask,
          decoration: const InputDecoration(
            suffixIcon: Icon(Icons.send),
            // suffixIcon: IconButton(
            //   onPressed: () {
            //     _addTask(input.text);
            //   },
            //   icon: const Icon(Icons.send),
            // ),
            hintText: 'Add new task',
          ),
        ),
      ],
    );
  }

  void _addTask(String value) {
    setState(() {
      todoCubit.addTodo(input.text);
    });
  }

  void _done(Todo task) {
    setState(() {
      todoCubit.done(task);
    });
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController input = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(todoCubit.state.todos.toList()[index].task),
              );
            },
            separatorBuilder: (_, __) => const Divider(),
            itemCount: todoCubit.state.todos.length,
          ),
        ),
        TextField(
          controller: input,
          onSubmitted: _addTask,
          decoration: const InputDecoration(
            suffixIcon: Icon(Icons.send),
            // suffixIcon: IconButton(
            //   onPressed: () {
            //     _addTask(input.text);
            //   },
            //   icon: const Icon(Icons.send),
            // ),
            hintText: 'Add new task',
          ),
        )
      ],
    );
  }

  void _addTask(String value) {
    setState(() {
      todoCubit.addTodo(input.text);
    });
  }

  void _done(Todo task) {
    setState(() {
      todoCubit.done(task);
    });
  }
}
