import 'package:cloud_firestore/cloud_firestore.dart';
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

  void openDialogBox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          docID == null ? "Add Task" : "Modify Task",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        content: TextField(
          controller: textEditingController,
        ),
        actions: [
          ElevatedButton(
            onPressed: docID == null
            ? () {
              tasks.addTask(textEditingController.text);
              Navigator.pop(context);
              textEditingController.clear();
            }
            : () {
              tasks.updateTask(docID, textEditingController.text);
              Navigator.pop(context);
              textEditingController.clear();
            },
            child: Icon(docID == null ? Icons.add : Icons.check),
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
      body: StreamBuilder(
        stream: tasks.getTasks,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List tasksList = snapshot.data.docs;
            return ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              itemCount: tasksList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = tasksList[index];
                return ToDoListTile(
                  onPressedSettings: () => openDialogBox(docID: doc.id),
                  onPressedDelete: () => tasks.deleteTask(doc.id),
                  taskString: doc['task'],
                  isChecked: doc['isChecked'],
                );
              }
            );
          }
          else {
            return Center(
              child: Text(
                'Loading Data...',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
        onPressed: () {
          openDialogBox();
        },
        child: Icon(Icons.create),
      ),
    );
  }
}