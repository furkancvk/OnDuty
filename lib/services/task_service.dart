import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_duty/models/task_model.dart';

class TaskService {
  final _tasks = FirebaseFirestore.instance.collection('tasks').withConverter(
    fromFirestore: TaskModel.fromFirestore,
    toFirestore: (TaskModel task, options) => task.toFirestore(),
  );

  void addTask(TaskModel task) async {
    await _tasks.add(task);
  }

  void updateTask(TaskModel task) async {
    await _tasks.doc(task.uid).update(task.toJson());
  }

  void deleteTask(String id) async {
    await _tasks.doc(id).delete();
  }

  void getTask(String id) async {
    await _tasks.doc(id).get();
  }

  void getTasks() async {
    await _tasks.get();
  }
}