import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/components/todolist_tile.dart';
import 'package:todolist/services/firebase.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
          autofocus: true,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (docID == null && textEditingController.text.trim() != '')
                tasks.addTask(textEditingController.text.trim());
              else {
                if (textEditingController.text.trim() == '') {
                  tasks.deleteTask(docID);
                }
                else {
                  tasks.updateTask(docID, textEditingController.text.trim());
                }
              }
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
              Icons.checklist_sharp,
              size: 25,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'TO-DO LIST',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
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
                  onPressedSettings: () {
                    textEditingController.value = TextEditingValue(text: doc['task']);
                    openDialogBox(docID: doc.id);
                  },
                  onPressedDelete: () => tasks.deleteTask(doc.id),
                  onChanged: () {
                    tasks.updateTaskState(
                      doc.id,
                      !doc['isChecked'],
                    );
                  },
                  taskString: doc['task'],
                  isChecked: doc['isChecked'],
                );
              }
            );
          }
          else {
            return Center(
              child: SpinKitWaveSpinner(
                color: Colors.black87,
                size: 80.0,
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black87,
        onPressed: () {
          textEditingController.clear();
          openDialogBox();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}