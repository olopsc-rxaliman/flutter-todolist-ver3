import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

  // Create
  Future addTask(String task) {
    return tasks.add({
      'task': task,
      'timestamp': Timestamp.now(),
    });
  }
}