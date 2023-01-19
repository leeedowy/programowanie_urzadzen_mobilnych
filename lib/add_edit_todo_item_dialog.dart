import 'package:flutter/material.dart';
import 'package:todo_list/todo_item.dart';

class AddEditTodoDialog extends StatefulWidget {
  final TodoItem? item;
  final Function(String, String)? addTodoItemCallback;
  final Function(String, String, int)? editTodoItemCallback;

  const AddEditTodoDialog({
    super.key,
    this.item,
    this.addTodoItemCallback,
    this.editTodoItemCallback
  });

  @override
  State<AddEditTodoDialog> createState() => _AddEditTodoDialogState();
}

class _AddEditTodoDialogState extends State<AddEditTodoDialog> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isConfirmEnabled = false;

  @override
  void initState() {
    super.initState();

    _titleController.text = widget.item?.title ?? "";
    _titleController.addListener(_onTitleChanged);
    _descriptionController.text = widget.item?.description ?? "";

    _isConfirmEnabled = _titleController.text.isNotEmpty;
  }

  void _onTitleChanged() {
    setState(() {
      _isConfirmEnabled = _titleController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${widget.addTodoItemCallback != null ? "Add" : "Edit"} Todo Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        Opacity(
          opacity: _isConfirmEnabled ? 1 : 0.5,
          child: TextButton(
            child: const Text('Confirm'),
            onPressed: () {
              if (_isConfirmEnabled) {
                setState(() {
                  String title = _titleController.text;
                  String description = _descriptionController.text;

                  if (widget.addTodoItemCallback != null) {
                    widget.addTodoItemCallback!(title, description);
                  }
                  if (widget.editTodoItemCallback != null) {
                    widget.editTodoItemCallback!(
                        title, description, widget.item?.index ?? -1);
                  }
                });
                Navigator.of(context).pop();
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _titleController.removeListener(_onTitleChanged);
    _titleController.dispose();
    super.dispose();
  }
}
