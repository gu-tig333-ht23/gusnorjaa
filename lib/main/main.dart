// The main file initializes the ToDo App with its primary routes. It utilizes the provider pattern
// for state management, specifically wrapping the whole app in a 'ChangeNotifierProvider' for the
// 'ToDoProvider'. The app consists of a homescreen, and a screen to add tasks. With a custom theme applied.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tig133_1/providers/todo_provider.dart';
import 'package:tig133_1/screens/homescreen.dart';
import 'package:tig133_1/screens/addtaskscreen.dart';
import 'package:tig133_1/styles/styles.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ToDoProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        theme: customThemeData,
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/addTask': (context) => AddTaskScreen(),
        },
      ),
    );
  }
}
