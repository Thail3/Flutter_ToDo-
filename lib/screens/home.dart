import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constant/colors.dart';
import 'package:flutter_todo_app/model/todo.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = Todo.TodoList();

  final _todoControlloer = TextEditingController();

  List<Todo> _foundToDo = [];

  @override
  void initState() {
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50, bottom: 20),
                      child: const Text(
                        "ALL TODOS",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                    ),
                    for (Todo todo in _foundToDo)
                      ToDoItem(
                        todo: todo,
                        onToDoChanged: _handleToDoChange,
                        onDeleteItem: _deleteToDoItme,
                      ),
                  ]),
                )
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(
                            bottom: 20, right: 20, left: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 10.0,
                                spreadRadius: 0.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: _todoControlloer,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            border: InputBorder.none,
                            hintText: "Add a new todo",
                            hintStyle: TextStyle(color: tdGray),
                          ),
                        )),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        _addToDoItems(_todoControlloer.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tdBlue,
                        minimumSize: const Size(60, 60),
                        elevation: 10,
                      ),
                      child: const Text(
                        '+',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  void _handleToDoChange(Todo? todo) {
    if (todo != null) {
      setState(() {
        todo.isDone = !todo.isDone;
      });
    }
  }

  void _deleteToDoItme(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItems(String toDo) {
    setState(() {
      todoList.add(Todo(
          todoText: toDo,
          id: DateTime.now().millisecondsSinceEpoch.toString()));
    });
    _todoControlloer.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<Todo> result = [];
    if (enteredKeyword.isEmpty) {
      result = todoList;
    } else {
      result = todoList.where((todo) {
        return todo.todoText!
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase());
      }).toList();
    }
    setState(() {
      _foundToDo = result;
    });
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
          onChanged: (value) => _runFilter(value),
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(0),
              prefixIcon: Icon(
                Icons.search,
                color: tdBlack,
                size: 20,
              ),
              prefixIconConstraints: BoxConstraints(
                maxHeight: 20,
                minWidth: 25,
              ),
              border: InputBorder.none,
              hintText: "Search",
              hintStyle: TextStyle(color: tdGray))),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu, color: tdBlack, size: 30),
          Text("TODO APP")
        ],
      ),
    );
  }
}
