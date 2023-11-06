// This file defines the 'TodoProvider' class which integrates the to-do operations with the backend service. Using the 'ChangeNotifier' mixin,
// it allows for reactive programming, notifying UI elements of changes. It provides methods for filtering, fetching, adding, updating, toggling
// completion and deleting to-dos.

import 'package:flutter/foundation.dart';
import 'package:tig133_1/models/todo.dart';
import 'package:tig133_1/services/todo_service.dart'; 

// Enum for different types of filtering options for todos.
enum TodoFilter { all, done, undone }

class ToDoProvider with ChangeNotifier {
  
  // List to store fetched todos from the API.
  List<Todo> _todos = [];
  
  // Filter type for todos. By default, shows all tasks.
  TodoFilter _filter = TodoFilter.all;

  // Instance of the service class to interact with the backend API.
  final TodoService _todoService = TodoService();

  // Getter to get all todos.
  List<Todo> get todos => _todos;

  // Getter to get todos based on the selected filter.
  List<Todo> get filteredTodos {
    switch (_filter) {
      case TodoFilter.done:
        return _todos.where((todo) => todo.done).toList();
      case TodoFilter.undone:
        return _todos.where((todo) => !todo.done).toList();
      case TodoFilter.all:
      default:
        return _todos;
    }
  }

  // Method to set filter type and notify listeners of the change.
  void setFilter(TodoFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  // Method to fetch all todos from the API.
  Future<void> fetchTodos() async {
  try {
    _todos = await _todoService.fetchTodos();
    notifyListeners();
  } catch (error) {
    if (kDebugMode) {
      print('Error fetching todos: $error');
    }
  }
}


  // Method to add a todo using the API and refresh the list.
  Future<void> addTodo(Todo todo) async {
  try {
    await _todoService.addTodo(todo);
    await fetchTodos(); 
  } catch (error) {
    if (kDebugMode) {
      print('Error adding todo: $error');
    }
  }
}


  // Method to toggle the completion status of a todo.
  Future<void> toggleDone(String id) async {
  int index = _todos.indexWhere((todo) => todo.id == id);
  if (index != -1) {
    try {
      _todos[index].done = !_todos[index].done;
      await _todoService.updateTodo(_todos[index]); 
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print('Error toggling todo completion: $error');
      }
    }
  }
}


  // Method to delete a todo based on its ID.
  Future<void> deleteTodo(String id) async {
    int index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      try {
      await _todoService.deleteTodo(id); 
      _todos.removeAt(index);
      notifyListeners();   
      } catch (error) {
        if (kDebugMode) {
          print('Error deleting todo: $error');
        }
      }
    }
  }

  // Method to update an existing todo.
  Future<void> updateTodo(Todo todo) async {
  int index = _todos.indexWhere((t) => t.id == todo.id);
  if (index != -1) {
    try {
      _todos[index] = todo;
      await _todoService.updateTodo(todo); 
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print('Error updating todo: $error');
      }
    }
  }
}
}
