// This file defines the 'AddTaskScreen' for the to-do app. It presents an input field for users
// to type a task and a button to add it. The task is added to the list upon submission, utilizing the
// 'TodoProvider' for data operations, after which the screen navigates back.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tig133_1/models/todo.dart';
import 'package:tig133_1/providers/todo_provider.dart';

class AddTaskScreen extends StatelessWidget {
  // Controller for the task input field.
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),  // AppBar with the screen title.
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _taskController,  // Setting the controller for the input.
              decoration: InputDecoration(
                labelText: 'Task',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),  // Provides spacing between the input and the button.
            ElevatedButton(
              child: Text('Add Task'),
              onPressed: () {
                // Adds the task to the provider if the input isn't empty.
                if (_taskController.text.isNotEmpty) {
                  Provider.of<ToDoProvider>(context, listen: false).addTodo(
                    Todo(id: DateTime.now().toString(), title: _taskController.text),
                  );
                  Navigator.pop(context);  // Returns to the previous screen.
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
