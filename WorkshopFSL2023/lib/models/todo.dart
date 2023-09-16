import 'package:flutter/material.dart';

@immutable
class Todo {
  final String task;
  final bool done;

  const Todo(this.task, this.done);

  factory Todo.neu(String task) {
    return Todo(task, false);
  }

  bool get isDone => done;
  bool get isNotDone => !done;

  Todo copyWith({
    String? task,
    bool? done,
  }) {
    return Todo(
      task ?? this.task,
      done ?? this.done,
    );
  }

  @override
  int get hashCode => Object.hash(task, done, task.runtimeType);

  @override
  bool operator ==(Object other) {
    return other is Todo &&
        other.runtimeType == runtimeType &&
        other.task == task &&
        other.done == done;
  }
}
