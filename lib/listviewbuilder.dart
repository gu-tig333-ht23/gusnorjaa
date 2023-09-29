import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:template/theme.dart';

class TaskItem {
  String task;
  bool completed;

  TaskItem(this.task, this.completed);
}

class ListViewBuilder extends StatefulWidget {
  ListViewBuilder({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListViewBuilderState createState() => _ListViewBuilderState();
}

// Skapar en lista med TaskItem objekt, ger parametrarna sina värden.

class _ListViewBuilderState extends State<ListViewBuilder> {
  List<TaskItem> tasks = [
    TaskItem("Eat a banana and take a long long walk in the sunset", false),
    TaskItem("Say hello to Calle", false),
    TaskItem("Finish the Flutter Course", false),
    TaskItem("Throw out the garbage", false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              tileColor: appTheme.colorScheme.secondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              leading: Checkbox(
                value: tasks[index]
                    .completed, //Kikar bool värdet på objektet i listan.
                onChanged: (bool? newValue) {
                  setState(() {
                    tasks[index].completed = newValue!;
                  });
                },
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      tasks[index].task, //Skriver ut sträng värdet på objektet.
                      style: GoogleFonts.lato(
                        decoration: tasks[index].completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationThickness: 2,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        tasks.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
