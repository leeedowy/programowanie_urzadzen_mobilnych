import 'package:flutter/material.dart';
import 'package:todo_list/add_edit_todo_item_dialog.dart';
import 'package:todo_list/todo_item.dart';
import 'package:todo_list/todo_item_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Todo List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<TodoItem> _todoItems = <TodoItem>[];



  void _addTodoItem(String title, String description) {
    setState(() {
      _todoItems.add(TodoItem(
          title: title,
          description: description,
        )
      );
    });
  }

  void _editTodoItem(String title, String description, int index) {
    setState(() {
      TodoItem item = _todoItems.firstWhere((item) => item.index == index);
      item.title = title;
      item.description = description;
    });
  }

  void _removeTodoItem(TodoItem item) {
    setState(() {
      _todoItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _todoItems.length,
        itemBuilder: (context, index) {
          _todoItems[index].index = index;
          return TodoItemWidget(
            key: UniqueKey(),
            item: _todoItems[index],
            onEdit: _editTodoItem,
            onDelete: _removeTodoItem,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddEditTodoDialog(
                key: UniqueKey(),
                addTodoItemCallback: _addTodoItem,
              );
            },
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
