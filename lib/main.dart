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
  final tasks = <String>['Task One', 'Task Two', 'Task Three', 'Task Four'];
  //print(_tasks.length);
  final _biggerFont = TextStyle(fontSize: 24);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My To Do List", style: TextStyle(fontSize: 32)),
      ),
      body: _buildTasks(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent[400],
        elevation: 5,
        onPressed: () {},
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
                title: Text(
                  task,
                  style: _biggerFont,
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
      ],
    );
  }
}