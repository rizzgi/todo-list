import 'package:app_list/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({Key? key, required this.todo, required this.onDelete})
      : super(key: key);

  final Todo todo;
  final Function(Todo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Slidable(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                DateFormat('dd/MM/yy - HH:mm').format(todo.datetime),
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                todo.title,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            icon: Icons.delete,
            backgroundColor: Colors.red,
            label: 'EXCLUIR',
            onPressed: doNothing,
          ),
        ]),
      ),
    );
  }

  void doNothing(BuildContext context) {
    onDelete(todo);
  }
}
