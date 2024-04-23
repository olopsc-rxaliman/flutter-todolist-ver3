import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

  // Create
  Future addTask(String task) {
    return tasks.add({
      'task': task,
      'isChecked': false,
      'timestamp': Timestamp.now(),
    });
  }

  // Retrieve
  Stream get getTasks => tasks.orderBy(
    'timestamp',
    descending: false,
  ).snapshots();

  // Update
  Future updateTask(String docID, String task) {
    return tasks.doc(docID).update({
      'task': task,
    });
  }

  // Delete
  Future deleteTask(String docID) => tasks.doc(docID).delete();
}