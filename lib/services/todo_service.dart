// This file defines the 'ToDoService' class responsible for interacting with an external API
// to manage to-dos. It provides methods to fetch, add, update, and delete to-do's. 
// The API endpoint and key are declared as constants.

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tig133_1/models/todo.dart';

// The base URL endpoint for the todo API.
const String ENDPOINT = 'https://todoapp-api.apps.k8s.gu.se';

// API key for accessing the endpoint.
const String apiKey = 'f4a4f479-771b-4166-9aa9-d72a76dae97d';

class TodoService {
  
  // Fetches all the todos from the API.
  Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse('$ENDPOINT/todos?key=$apiKey'));

    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Todo.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  // Adds a new todo to the API.
  Future<void> addTodo(Todo todo) async {
    final response = await http.post(
      Uri.parse('$ENDPOINT/todos?key=$apiKey'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(todo.toJsonWithoutId()),
    );
    
    if (response.statusCode != 200) {
      throw Exception('Failed to add todo');
    }
  }

  // Updates an existing todo in the API based on its ID.
  Future<void> updateTodo(Todo todo) async {
    final response = await http.put(
      Uri.parse('$ENDPOINT/todos/${todo.id}?key=$apiKey'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(todo.toJsonWithoutId()),
    );
    
    if (response.statusCode != 200) {
      throw Exception('Failed to update todo');
    }
  }

  // Deletes a todo from the API based on its ID.
  Future<void> deleteTodo(String id) async {
    final response = await http.delete(Uri.parse('$ENDPOINT/todos/$id?key=$apiKey'));
    
    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }
}
