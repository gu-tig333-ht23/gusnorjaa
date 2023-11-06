// This file defines the main screen of the to-do application. It showcases a list of tasks
// that users can interact with. Features include:
// * Viewing all tasks with an option to filter by their status (all, completed or pending)
// * Adding a new task using a floating action button
// * Editing an existing task by tapping on it, which brings up an edit dialog.
// * Marking tasks as completed using checkboxes
// * Deleting tasks with a swipe-to-delete gesture, which also prompts for confirmation before deletion.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tig133_1/models/todo.dart';
import 'package:tig133_1/providers/todo_provider.dart';
import 'package:tig133_1/styles/styles.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // When the widget is initialized, tasks are fetched.
  @override
  void initState() {
    super.initState();
    _fetchInitialTodos();
  }

  _fetchInitialTodos() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ToDoProvider>(context, listen: false).fetchTodos();
    });
  }

  // Builds the main screen with the app bar, the list of tasks, and an add-task button.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Consumer<ToDoProvider>(
        builder: (context, todoProvider, child) {
          return _buildTodoList(todoProvider);
        },
      ),
      floatingActionButton: _buildAddTodoButton(),
    );
  }

  // Builds the app bar with a title and a filter button.
  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text('To-do List', style: customHeaderFont1),
      actions: [
        _buildFilterButton(),
      ],
    );
  }

  // Creates a button in the app bar to filter the tasks.
  Widget _buildFilterButton() {
    return PopupMenuButton<TodoFilter>(
      onSelected: (filter) {
        Provider.of<ToDoProvider>(context, listen: false).setFilter(filter);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<TodoFilter>>[
        const PopupMenuItem<TodoFilter>(
          value: TodoFilter.all,
          child: Text('All'),
        ),
        const PopupMenuItem<TodoFilter>(
          value: TodoFilter.done,
          child: Text('Completed'),
        ),
        const PopupMenuItem<TodoFilter>(
          value: TodoFilter.undone,
          child: Text('Pending'),
        ),
      ],
    );
  }

  // Builds the actual list of tasks.
  Widget _buildTodoList(ToDoProvider todoProvider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: todoProvider.filteredTodos.length,
        itemBuilder: (context, index) {
          return _buildTodoItem(todoProvider, todoProvider.filteredTodos[index]);
        },
      ),
    );
  }

  // Creates a task item with swipe-to-delete functionality.
  Widget _buildTodoItem(ToDoProvider todoProvider, Todo todo) {
    return Dismissible(
      key: Key(todo.id),
      movementDuration: Duration(milliseconds: 200),
      dismissThresholds: {
        DismissDirection.endToStart: 0.2,
      },
      direction: DismissDirection.endToStart,
      background: _buildDeleteBackground(),
      confirmDismiss: (direction) async {
        return await _confirmDelete(context, todoProvider, todo);
      },
      onDismissed: (direction) => _handleDismissed(todoProvider, todo, direction),
      child: _buildTodoCard(todo, todoProvider),
    );
  }

  // Background displayed when swiping a task for deletion.
  Container _buildDeleteBackground() {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.error,
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Icon(Icons.delete, color: colorScheme.onError),
      ),
    );
  }

  // Confirmation dialog displayed when user tries to delete a task.
  Future<bool> _confirmDelete(BuildContext context, ToDoProvider todoProvider, Todo todo) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Do you want to delete this task?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                todoProvider.deleteTodo(todo.id);
                Navigator.of(context).pop(true);
              },
              child: Text('Delete',
              style: customErrorFont),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel',
              style: customStandardFont1),
            ),
          ],
        );
      },
    ) ?? false;
  }

  // Handles the task deletion upon swiping.
  void _handleDismissed(ToDoProvider todoProvider, Todo todo, DismissDirection direction) {
    if (direction == DismissDirection.endToStart) {
      todoProvider.deleteTodo(todo.id);
    }
  }

  // Displays a dialog to edit a task when clicked.
  void _showEditTodoDialog(ToDoProvider todoProvider, Todo todo) async {
    TextEditingController _controller = TextEditingController(text: todo.title);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Task'),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(labelText: 'Task'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (_controller.text.isNotEmpty) {
                Todo updatedTodo = Todo(id: todo.id, title: _controller.text, done: todo.done);
                await todoProvider.updateTodo(updatedTodo);
                Navigator.of(context).pop();
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  // Creates a card for each task in the list.
  Card _buildTodoCard(Todo todo, ToDoProvider todoProvider) {
    return Card(
      elevation: cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: cardBorderRadius,
      ),
      margin: cardMargin,
      child: ListTile(
        onTap: () => _showEditTodoDialog(todoProvider, todo),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Checkbox(
          value: todo.done,
          // Toggles the task's completion status when the checkbox is clicked.
          onChanged: (bool? value) => Provider.of<ToDoProvider>(context, listen: false).toggleDone(todo.id),
        ),
        title: Text(
          todo.title,
          // Shows a strikethrough effect if the task is marked as completed.
          style: TextStyle(decoration: todo.done ? TextDecoration.lineThrough : null,
          decorationThickness: 2,
          ),
        ),
      ),
    );
  }

  // Creates a floating action button that navigates the user to an 'Add Task' screen.
  FloatingActionButton _buildAddTodoButton() {
    return FloatingActionButton(
      elevation: 5,
      backgroundColor: Colors.grey,
      child: Icon(Icons.add,
      color: Colors.white,
      ),
      onPressed: () => Navigator.pushNamed(context, '/addTask'),
    );
  }
}





