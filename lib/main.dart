import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

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
  var tasks = <String>[]; // Initialising an empty list ready for later use
  var textFieldVis = false; // On startup, I want the text field box to be hidden

  TextEditingController taskController = TextEditingController();

  void setTextVis() { // Inverting the visibility of the text field. If it's hidden, show it and vice versa
    if (textFieldVis = false)
      textFieldVis = true;
    else
      textFieldVis = false;
  }

  void addTaskToList() {
    tasks.insert(0, taskController.text); // Insert the text input from the text field into the tasks list
  }

  save(textList) async { // Method for saving the list of tasks locally (persistent)
    var textToWrite = '';
    final dir = await getApplicationDocumentsDirectory(); // Find the application's documents directory
    final file = File('${dir.path}/tasks.txt'); // Add the file name of the file we're concerned with to the end
        for (var i = 0; i < tasks.length; i++) {
      textToWrite += (tasks.reversed.toList()[i] + "\n");
    }
    await file.writeAsString(textToWrite); // Write the passed in text, as well as a new line
    // A new line is added so that, when reading the file, 'readAsLines' will generate a list for each separate task
  }

  read() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/tasks.txt');
      var contents = await file.readAsLines();
      contents = contents.reversed.toList();
      setState(() {
        tasks = contents;
      });
    }
    catch (error) { // Output the offending error
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    read();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do List", style: TextStyle(fontSize: 32)),
      ),
      body: _buildTasks(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        onPressed: () {
          setState(() {
            textFieldVis = true;
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.grey[900],
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
                    save(tasks);
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
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  labelText: "Enter task",
                ),
                onFieldSubmitted: (String str) {
                  setState(() {
                    addTaskToList();
                    textFieldVis = false;
                    save(tasks);
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