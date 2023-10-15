import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'To-Do App',
        theme: ThemeData(primarySwatch: Colors.teal),
        home: const ToDoScreen());
  }
}

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() {
    return _ToDoList();
  }
}

class _ToDoList extends State<ToDoScreen> {
  List<TodoItem> todo = [];
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do App'),
        leading: Container(
            width: 105, height: 10, child: Image.asset('lib/assets/tick.png')),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Add a new task',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      String task = textEditingController.text;
                      if (task.isNotEmpty) {
                        todo.add(TodoItem(task, false));
                        textEditingController.clear();
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.teal,
                  )),
            ],
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: todo.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    value: todo[index].isDone,
                    checkColor: Color.fromARGB(255, 212, 242, 213),
                    onChanged: (bool? newValue) {
                      setState(() {
                        todo[index].isDone = newValue ?? false;
                      });
                    },
                    title: Text(todo[index].task,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 70, 80, 85),
                            fontWeight: FontWeight.w500)),
                    controlAffinity: ListTileControlAffinity.leading,
                    secondary: IconButton(
                        onPressed: () {
                          setState(() {
                            todo.removeAt(index);
                          });
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(219, 255, 107, 112),
                        )),
                  );
                }))
      ]),
    );
  }
}

class TodoItem {
  String task;
  bool isDone;

  TodoItem(this.task, this.isDone);
}
