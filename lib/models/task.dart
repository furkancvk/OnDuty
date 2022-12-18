import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_duty/models/user.dart';

class TaskModel {
  String? uid;
  String? title;
  String? description;
  int? importance;
  UserModel? user;
  String? dueDate;
  Timestamp? createdAt;

  // DateTime? updatedAt;

  TaskModel({
    this.uid,
    this.title,
    this.description,
    this.importance,
    this.user,
    this.dueDate,
    this.createdAt,
    // this.updatedAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        uid: json["uid"] as String?,
        title: json["title"] as String,
        description: json["description"] as String,
        importance: json["importance"] as int,
        user: UserModel.fromJson(json["user"]),
        dueDate: json["dueDate"] as String,
        createdAt: json["createdAt"] as Timestamp,
        // updatedAt: json["updatedAt"] as DateTime,
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "title": title,
        "description": description,
        "importance": importance,
        "user": user?.toJson(),
        "dueDate": dueDate,
        "createdAt": createdAt,
        // "updatedAt": updatedAt,
      };

  factory TaskModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return TaskModel(
      uid: data?['uid'],
      title: data?['title'],
      description: data?['description'],
      importance: data?['importance'],
      user: UserModel.fromJson(data?["user"]),
      dueDate: data?['dueDate'],
      createdAt: data?['createdAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "uid": uid,
      if (title != null) "title": title,
      if (description != null) "description": description,
      if (importance != null) "importance": importance,
      if (user != null) "user": user?.toFirestore(),
      if (dueDate != null) "dueDate": dueDate,
      if (createdAt != null) "createdAt": createdAt,
    };
  }
}
