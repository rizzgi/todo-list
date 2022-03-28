import 'package:app_list/models/todo.dart';
import 'package:app_list/widgets/todo_list_item.dart';
import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();
  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoPosition;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: todoController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Adicione uma tarefa',
                            hintText: 'Estudar Flutter'),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String text = todoController.text;
                        setState(() {
                          Todo newTodo =
                              Todo(title: text, datetime: DateTime.now());
                          todos.add(newTodo);
                        });
                        todoController.clear();
                      },
                      child: const Icon(Icons.add, size: 30),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.tealAccent,
                          padding: const EdgeInsets.all(14)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in todos)
                        TodoListItem(
                          todo: todo,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                            'Você possui ${todos.length} tarefas pendentes')),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: showDialogDeleteAll,
                      child: const Text('Limpar tudo'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.tealAccent,
                          padding: const EdgeInsets.all(14)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPosition = todos.indexOf(todo);
    setState(() {
      todos.remove(todo);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Tarefa ${todo.title} foi removida!",
        style: const TextStyle(color: Colors.white),
      ),
      action: SnackBarAction(
        label: 'Desfazer',
        textColor: Colors.cyanAccent,
        onPressed: () {
          setState(() {
            todos.insert(deletedTodoPosition!, deletedTodo!);
          });
        },
      ),
    ));
  }

  void showDialogDeleteAll() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar tudo?'),
        content: const Text('Voce tem certeza que deseja apagar tudo?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar')),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deleteAllList();
            },
            child: const Text('Limpar tudo'),
            style: TextButton.styleFrom(primary: Colors.red),
          ),
        ],
      ),
    );
  }

  void deleteAllList() {
    setState(() {
      todos.clear();
    });
  }
}
