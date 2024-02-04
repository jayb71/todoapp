import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ToDo App'),
    );
  }
}

final List<Todo> _todos = <Todo>[];

class Todo {
  Todo({
    required this.title,
    required this.description,
    required this.isDone,
    required this.deadline,
  });

  final String title;
  final String description;
  final String deadline;
  bool isDone;
}

void addTodo(Todo todo) {
  _todos.add(todo);
  _titlecontroller.clear();
  _descriptioncontroller.clear();
  _deadlinecontroller.text = 'null';
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    void addTask() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AddTaskPage()));
    }

    void showTask() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ShowTaskPage()));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: const Color.fromARGB(255, 7, 115, 255),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              const Text(
                style: TextStyle(fontSize: 30),
                'Welcome to the ToDo App!',
              ),
              Container(
                margin: const EdgeInsets.all(50.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(50.0),
                      backgroundColor: const Color.fromARGB(255, 247, 173, 247),
                    ),
                    onPressed: addTask,
                    child: const Text('Add Task')),
              ),
              Container(
                margin: const EdgeInsets.all(50.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(50.0),
                      backgroundColor: const Color.fromARGB(255, 247, 173, 247),
                    ),
                    onPressed: showTask,
                    child: const Text('Show Task')),
              ),
            ]),
          ),
        ));
  }
}

final TextEditingController _titlecontroller = TextEditingController();
final TextEditingController _descriptioncontroller = TextEditingController();
final TextEditingController _deadlinecontroller =
    TextEditingController(text: 'null');

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        backgroundColor: const Color.fromARGB(255, 7, 115, 255),
      ),
      body: Center(
        child: Column(children: [
          const Text(style: TextStyle(fontSize: 30), 'Add a new task here!'),
          Form(
              child: Column(
            children: [
              TextFormField(
                controller: _titlecontroller,
                decoration: const InputDecoration(
                  labelText: 'Task Name',
                ),
              ),
              TextFormField(
                controller: _descriptioncontroller,
                decoration: const InputDecoration(
                  labelText: 'Task Description',
                ),
              ),
              TextFormField(
                  controller: _deadlinecontroller,
                  decoration: const InputDecoration(
                    labelText: 'Task Deadline',
                  )),
              Container(
                margin: const EdgeInsets.all(50.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20.0),
                  ),
                  onPressed: () {
                    addTodo(Todo(
                      title: _titlecontroller.text,
                      description: _descriptioncontroller.text,
                      deadline: _deadlinecontroller.text,
                      isDone: false,
                    ));
                    Navigator.pop(context);
                  },
                  child: const Text('Add Task'),
                ),
              ),
            ],
          ))
        ]),
      ),
    );
  }
}

class TodoItem extends StatelessWidget {
  const TodoItem(
      {super.key,
      required this.todo,
      required this.onDelete,
      required this.onCheck});
  final Todo todo;
  final VoidCallback onDelete;
  final VoidCallback onCheck;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(todo.title,
            style: todo.isDone
                ? const TextStyle(decoration: TextDecoration.lineThrough)
                : null),
        // subtitle: Text(todo.description),
        subtitle: Column(
          children: [
            Text(todo.description,
                style: todo.isDone
                    ? const TextStyle(decoration: TextDecoration.lineThrough)
                    : null),
            Text('Deadline: ${todo.deadline}',
                style: todo.isDone
                    ? const TextStyle(decoration: TextDecoration.lineThrough)
                    : null),
          ],
        ),
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (bool? value) {
            onCheck();
          },
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            //_todos.remove(widget.todo);
            onDelete();
          },
        ));
  }
}

class ShowTaskPage extends StatefulWidget {
  const ShowTaskPage({super.key});
  @override
  State<ShowTaskPage> createState() => _ShowTaskPageState();
}

class _ShowTaskPageState extends State<ShowTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Task'),
        backgroundColor: const Color.fromARGB(255, 7, 115, 255),
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          return TodoItem(
              todo: _todos[index],
              onDelete: () {
                setState(() {
                  _todos.removeAt(index);
                });
              },
              onCheck: () {
                setState(() {
                  _todos[index].isDone = !_todos[index].isDone;
                });
              });
        },
      ),
    );
  }
}



// checklist: checkbox, time, deadline