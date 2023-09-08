import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_task.dart';
import 'listviewbuilder.dart';
import 'theme.dart';

//Importerar flutter, google_fonts och add_task sidan.

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'To-Do List',
          style: GoogleFonts.lato(fontSize: 32),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      //Skapar en AlertDialog (liten box) med tre alternativ. För tillfället inte klickbara.
                      scrollable: true,
                      title: const Text('Filter'),
                      content: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(children: [
                          Row(
                            children: [
                              Icon(Icons.check_box_outline_blank),
                              Text('All'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.check_box_outline_blank),
                              Text('Not done'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.check_box_outline_blank),
                              Text('Done'),
                            ],
                          ),
                        ]),
                      ),
                    );
                  },
                );
              },
              child: Stack(
                //Knapp för att filtrera
                children: [
                  Center(
                    child: Icon(Icons.sort),
                  ),
                ],
              ),
            ),
          )
        ],
      ),

      body: ListViewBuilder(), //Kallar på en annan funktion i body.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, //Navigator för att ta sig till andra sidan.
              MaterialPageRoute(builder: (context) => const AddTask()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    theme: appTheme,
    home: MyApp(),
  ));
}
