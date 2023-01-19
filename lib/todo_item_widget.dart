import 'package:flutter/material.dart';
import 'package:todo_list/todo_item.dart';

import 'add_edit_todo_item_dialog.dart';

class TodoItemWidget extends StatefulWidget {
  final TodoItem item;
  final Function(TodoItem) onDelete;
  final Function(String, String, int) onEdit;

  const TodoItemWidget({
    super.key,
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onLongPress: () {
          _showDeleteDialog(context);
        },
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddEditTodoDialog(
                key: UniqueKey(),
                item: widget.item,
                editTodoItemCallback: widget.onEdit,
              );
            },
          );
        },
        child: ListTile(
          title: Text(widget.item.title,
            style: TextStyle(
                decoration: (widget.item.isCompleted ?? false) ? TextDecoration.lineThrough : TextDecoration.none
            ),
          ),
          subtitle: Text(widget.item.description,
            style: TextStyle(
                decoration: (widget.item.isCompleted ?? false) ? TextDecoration.lineThrough : TextDecoration.none
            ),
          ),
          trailing: Checkbox(
            value: widget.item.isCompleted,
            onChanged: (bool? value) {
              setState(() {
                widget.item.isCompleted = !(widget.item.isCompleted ?? false);
              });
            },
          ),
        ),
      )
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Todo"),
          content: Text("Are you sure you want to delete this todo?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () {
                setState(() {
                  widget.onDelete(widget.item);
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }
}
