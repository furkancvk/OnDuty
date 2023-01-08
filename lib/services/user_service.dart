import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_duty/models/user_model.dart';

class UserService {
  final _users = FirebaseFirestore.instance.collection('users').withConverter(
    fromFirestore: UserModel.fromFirestore,
    toFirestore: (UserModel user, options) => user.toFirestore(),
  );

  void addUser(UserModel user) async {
    await _users.doc(user.uid).set(user);
  }

  void updateUser(UserModel user) async {
    await _users.doc(user.uid).update(user.toJson());
  }

  void deleteUser(String id) async {
    await _users.doc(id).delete();
  }

  void getUser(String id) async {
    await _users.doc(id).get();
  }

  void getUsers() async {
    await _users.get();
  }
}