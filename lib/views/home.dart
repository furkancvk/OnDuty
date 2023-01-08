import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:on_duty/widgets/cards/task_card.dart';
import 'package:on_duty/widgets/inputs/date_input.dart';
import 'package:on_duty/widgets/modals/alert_modal.dart';
import 'package:provider/provider.dart';

import '../design/app_colors.dart';
import '../design/app_text.dart';
import '../models/task_model.dart';
import '../models/user_model.dart';
import '../services/notification_service.dart';
import '../states/states.dart';
import '../utils/helpers.dart';
import '../widgets/app_alerts.dart';
import '../widgets/inputs/text_input.dart';
import 'edit_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  final _tasksStream =
      FirebaseFirestore.instance.collection('tasks').withConverter<TaskModel>(
            fromFirestore: TaskModel.fromFirestore,
            toFirestore: (TaskModel task, options) => task.toFirestore(),
          );
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  final TextEditingController _searchController = TextEditingController();
  static final CollectionReference _tasks =
  FirebaseFirestore.instance.collection('tasks');

  late bool isAdmin;
  String _searchQuery = "";
  String _displayName = "";
  DateTime? selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    isAdmin = false;
    setDisplayName();
    setIsAdmin();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if(isAdmin) Navigator.pushNamed(context, "notifications_screen");
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isNewNotification = Provider.of<States>(context).newNotification;
    Function changeNewNotification = Provider.of<States>(context).changeNewNotification;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Ana Sayfa"),
          actions: [
            if (isAdmin)
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  IconButton(
                    splashRadius: 24,
                    onPressed: () => {
                      Navigator.pushNamed(context, "notifications_screen"),
                      changeNewNotification(false),
                    },
                    icon: const Icon(Iconsax.notification),
                  ),
                  if(isNewNotification) Positioned(
                    top: 16,
                    right: 14,
                    child: Container(
                      height: 9,
                      width: 9,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                        border: Border.all(width: 1, color: AppColors.lightSecondary),
                      ),
                    ),
                  )
                ],
              ),
            IconButton(
              splashRadius: 24,
              onPressed: () => showMessageLogOut(context),
              icon: const Icon(FluentIcons.arrow_exit_20_regular),
            ),
            const SizedBox(width: 12),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("Hoş geldin, ", style: AppText.labelSemiBold),
                    Text(
                      Helpers.titleCase(_displayName),
                      style: AppText.label,
                    ),
                  ],
                ),
                Text(
                  DateFormat.MMMMEEEEd("tr").format(DateTime.now()),
                  style: AppText.labelSemiBold,
                )
              ],
            ),
            const SizedBox(height: 16),
            Divider(
              thickness: 1,
              color: AppColors.lightPrimary.withOpacity(.16),
            ),
            const SizedBox(height: 24),
            TextInput(
              controller: _searchController,
              onChanged: (String value) => setState(() => _searchQuery = value),
              hint: "Görev Ara...",
              suffixIcon: const Icon(
                FluentIcons.search_24_filled,
                color: AppColors.lightPrimary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              isAdmin ? "Atanan Görevler" : "Görevleriniz",
              style: AppText.titleSemiBold,
            ),
            const SizedBox(height: 16),
            StreamBuilder<QuerySnapshot<TaskModel>>(
                stream: _tasksStream
                    .where('user.uid', isEqualTo: isAdmin ? null : _auth.currentUser?.uid)
                    .where('isCompleted', isEqualTo: false)
                    .orderBy('importance', descending: false)
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  } else if (snapshot.data?.size == 0) {
                    return Image.asset("assets/images/not_found.png");
                  } else {
                    List tasks = snapshot.data!.docs.map((doc) {
                      TaskModel taskData = doc.data() as TaskModel;
                      taskData.uid = doc.id;
                      return taskData;
                    }).toList();

                    tasks = tasks.where((s) => s.title.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

                    if (tasks.isEmpty) {
                      return Image.asset("assets/images/list_empty.png");
                    }

                    return Column(
                      children: tasks.map((task) {
                        List<Map<String, dynamic>> data = [
                          if(isAdmin) {
                            "title": "Düzenle",
                            "icon": FluentIcons.edit_24_regular,
                            "onPress": () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditTaskScreen(task: task),
                              ),
                            ),
                          },
                          if(isAdmin) {
                            "title": "Sil",
                            "icon": FluentIcons.delete_24_regular,
                            "onPress": () => showMessageDeleteTask(task.uid, context),
                          },
                          if(!isAdmin) {
                            "title": "Tamamla",
                            "icon": FluentIcons.checkmark_24_regular,
                            "onPress": () => showMessageCompleteTask(task, context),
                          }
                        ];
                        
                        return TaskCard(
                          margin: const EdgeInsets.only(bottom: 24),
                          task: task,
                          data: data,
                        );
                      }).toList(),
                    );
                  }
                }),
          ],
        ),
        floatingActionButton: isAdmin
            ? FloatingActionButton(
                onPressed: () =>
                    Navigator.pushNamed(context, "new_task_screen"),
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }

  void setDisplayName() {
    setState(() {
      _displayName = _auth.currentUser!.displayName.toString();
    });
  }

  void setIsAdmin() async {
    final docSnap = await _users
        .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel user, options) => user.toFirestore(),
        )
        .doc(_auth.currentUser!.uid)
        .get();

    final currentUser = docSnap.data();

    setState(() {
      isAdmin = (currentUser?.isAdmin ?? false);
    });
  }

  Future<UserModel?> getUser(String id) async {
    final docSnap = await _users
        .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel user, options) => user.toFirestore(),
        )
        .doc(id)
        .get();

    return docSnap.data();
  }

  void logOut() {
    _auth.signOut().then((value) => {
          Navigator.pushReplacementNamed(context, 'login_screen'),
        });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void showMessageLogOut(context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertModal(
          title: "Çıkış Yap",
          content: "Çıkış yapmak istediğinizden emin misiniz?",
          actions: [
            OutlinedButton(
              child: const Text("Evet, çıkış yap"),
              onPressed: () => logOut(),
            ),
            ElevatedButton(
              child: const Text("Geri dön"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }

  void completeTask(TaskModel task, context) {
    NotificationService notificationService = NotificationService();

    TaskModel newTask = TaskModel(
      uid: task.uid,
      title: task.title,
      description: task.description,
      importance: task.importance,
      user: task.user,
      isCompleted: true,
      dueDate: task.dueDate,
      createdAt: task.createdAt,
    );

    _tasks
        .withConverter(
      fromFirestore: TaskModel.fromFirestore,
      toFirestore: (TaskModel task, options) => task.toFirestore(),
    )
        .doc(task.uid)
        .update(newTask.toJson())
        .then((value) => {
      Navigator.pop(context),
      AppAlerts.toast(message: "Yuppi! Görevi tamamladın."),
      notificationService.create(_auth.currentUser?.uid, "9qATBkfTqbba4y72INDl7SASmcu1", newTask.uid, "Görev tamamlandı!", false),
    });
  }

   void deleteTask(id, context) async {
    _tasks.doc(id).delete().then((value) => {
      Navigator.pop(context),
      AppAlerts.toast(message: "Görev başarıyla silindi."),
    });
  }

   void showMessageDeleteTask(id, context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertModal(
          title: "Görev Sil",
          content: "Seçtiğiniz görevi silmek üzereseniz, emin misiniz?\nBu işlem geri alınamaz.",
          actions: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.lightError),
              ),
              child: const Text(
                "Evet, sil",
                style: TextStyle(color: AppColors.lightError),
              ),
              onPressed: () => deleteTask(id, context),
            ),
            ElevatedButton(
              child: const Text("Hayır, silme"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

   void showMessageCompleteTask(task, context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Görev Tamamla",
            textAlign: TextAlign.center,
            style: AppText.titleSemiBold,
          ),
          content: const Text(
            "Seçtiğiniz görevin tamamlandığından, emin misiniz? Admin bu işlemden haberdar olacaktır.",
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.only(bottom: 24),
          actions: [
            ElevatedButton(
              child: const Text("Evet, tamamla"),
              onPressed: () => completeTask(task, context),
            ),
            OutlinedButton(
              child: const Text("Hayır, kapat"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

}

