import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constant/colors.dart';
import 'package:flutter_todo_app/model/todo.dart';

class ToDoItem extends StatelessWidget {
  final Todo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem(
      {super.key, required this.todo, this.onToDoChanged, this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          print("Clicked on Todo Item");
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone! ? Icons.check_box : null,
          color: tdBlue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: tdBlack,
              decoration: todo.isDone! ? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            onPressed: () {
              print("Clicked on Delete Button");
              onDeleteItem(todo.id!);
            },
            icon: Icon(Icons.delete),
            color: Colors.white,
            iconSize: 18,
          ),
        ),
      ),
    );
  }
}
