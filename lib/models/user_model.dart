import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? firstName;
  String? lastName;
  String? email;
  bool? isAdmin;
  String? password;
  // FieldValue? tokens;
  Timestamp? createdAt;

  UserModel({
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.isAdmin,
    this.password,
    // this.tokens,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"] as String?,
        firstName: json["firstName"] as String,
        lastName: json["lastName"] as String,
        email: json["email"] as String,
        isAdmin: json["isAdmin"] as bool,
        password: json["password"] as String?,
        // tokens: json["tokens"] as FieldValue,
        createdAt: json["createdAt"] as Timestamp,
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "isAdmin": isAdmin,
        "password": password,
        // "tokens": tokens,
        "createdAt": createdAt,
      };

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      uid: data?['uid'],
      firstName: data?['firstName'],
      lastName: data?['lastName'],
      email: data?['email'],
      isAdmin: data?['isAdmin'],
      password: data?['password'],
      // tokens: data?['tokens'],
      createdAt: data?['createdAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "uid": uid,
      if (firstName != null) "firstName": firstName,
      if (lastName != null) "lastName": lastName,
      if (email != null) "email": email,
      if (isAdmin != null) "isAdmin": isAdmin,
      if (password != null) "password": password,
      // if (tokens != null) "tokens": tokens,
      if (createdAt != null) "createdAt": createdAt,
    };
  }
}
