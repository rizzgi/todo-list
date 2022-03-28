import 'package:app/widgets/todo_list_item.dart';
import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();
  List<String> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Adicione uma tarefa',
                        hintText: 'Estudar Flutter'),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    String text = todoController.text;
                    setState(() {
                      todos.add(text);
                    });
                    todoController.clear();
                  },
                  child: Icon(Icons.add, size: 30),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.tealAccent, padding: EdgeInsets.all(14)),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (String todo in todos)
                    TodoListItem(
                      title: todo,
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(child: Text('Você não possui tarefas pendentes')),
                SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Limpar tudo'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.tealAccent, padding: EdgeInsets.all(14)),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
