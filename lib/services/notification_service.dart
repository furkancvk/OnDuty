import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:on_duty/models/notification.dart';
import 'package:on_duty/models/user.dart';
import 'package:on_duty/storage/storage.dart';
import 'package:on_duty/widgets/app_alerts.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final SecureStorage _secureStorage = SecureStorage();
  final CollectionReference _notifications = FirebaseFirestore.instance.collection('notifications');

  void connect() async {
    await Firebase.initializeApp();
    _messaging.getToken().then((token) => {
          log("FCM Token: $token"),
          _secureStorage.writeSecureData("fcm-token", token!),
        });
    _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AppAlerts.toast(message: message.notification!.title!);
    });
  }

  static Future<void> backgroundNotification(RemoteMessage message) async {
    await Firebase.initializeApp();
    log("Handling a background message: ${message.messageId}");
  }

  void create(senderId, title, description) async {
    final senderUser = await FirebaseFirestore.instance
        .collection('users')
        .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel user, options) => user.toFirestore(),
        ).doc(senderId).get();
    /*final receiverUser = await FirebaseFirestore.instance
        .collection('users')
        .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel user, options) => user.toFirestore(),
        ).doc(receiverId).get();*/

    NotificationModel newNotification = NotificationModel(
      senderUser: senderUser.data(),
      // receiverUser: receiverUser.data(),
      title: title,
      description: description,
      isRead: false,
      createdAt: Timestamp.now(),
    );

    _notifications.withConverter(
      fromFirestore: NotificationModel.fromFirestore,
      toFirestore: (NotificationModel notification, options) => notification.toFirestore(),
    ).add(newNotification);
  }
}
