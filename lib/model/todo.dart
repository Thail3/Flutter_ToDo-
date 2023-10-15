// import 'package:flutter/material.dart';

class Todo {
  String? id;
  String? todoText;
  bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<Todo> TodoList() {
    return [
      Todo(
        id: "1",
        todoText: "Learn Flutter",
        isDone: false,
      ),
      Todo(
        id: "2",
        todoText: "Learn Dart",
        isDone: false,
      ),
      Todo(
        id: "3",
        todoText: "Learn Dart",
        isDone: false,
      ),
    ];
  }
}
