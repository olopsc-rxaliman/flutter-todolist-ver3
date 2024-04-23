import 'package:flutter/material.dart';
import 'package:todolist/components/todolist_tile.dart';
import 'package:todolist/services/firebase.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirestoreService tasks = FirestoreService();
  TextEditingController textEditingController = TextEditingController();

  void openDialogBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Add New Task",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        content: TextField(
          controller: textEditingController,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              tasks.addTask(textEditingController.text);
              Navigator.pop(context);
              textEditingController.clear();
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.yellow,
        title: Row(
          children: [
            Icon(
              Icons.create,
              size: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'TO-DO LIST',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return ToDoListTile();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
        onPressed: () {
          openDialogBox();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}