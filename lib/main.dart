import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: TasksToDo()
    );
  }
}

class TasksToDo extends StatefulWidget {
  @override
  _TasksToDoState createState() => _TasksToDoState();
}

class _TasksToDoState extends State<TasksToDo> {
  final tasks = <String>[];
  var textFieldVis = false;
  var result = '';

  TextEditingController taskController = TextEditingController();

  void setTextVis() {
    if (textFieldVis = false)
      textFieldVis = true;
    else
      textFieldVis = false;
  }

  void addTaskToList() {
    tasks.insert(0, taskController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do List", style: TextStyle(fontSize: 32)),
      ),
      body: _buildTasks(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent[400],
        elevation: 0,
        onPressed: () {
          setState(() {
            textFieldVis = true;
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          ),
      ),
    );
  }
  Widget _buildTasks() {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.separated(
            itemCount: tasks.length,
            itemBuilder: (context, i) {
              final task = tasks[i];
              return ListTile(
                dense: true,
                title: Text(
                  task,
                  style: TextStyle(fontSize: 16),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete_rounded),
                  color: Colors.red,
                  onPressed: () {
                    setState(() {
                      tasks.removeAt(i);
                    });
                  },
                ),
              );
            },
            separatorBuilder: (context, index){
              return Divider();
            },
          ),
        ),
        SafeArea(
          child: Visibility(
            visible: textFieldVis,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 80, 14),
              child: TextFormField(
                controller: taskController,
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(),
                  labelText: "Enter task",
                ),
                onFieldSubmitted: (String str) {
                  setState(() {
                    addTaskToList();
                    textFieldVis = false;
                  });
                  taskController.clear();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}