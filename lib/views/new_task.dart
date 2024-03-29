import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_duty/design/app_colors.dart';
import 'package:on_duty/models/task_model.dart';
import 'package:on_duty/services/notification_service.dart';
import 'package:on_duty/widgets/inputs/date_input.dart';
import 'package:on_duty/widgets/inputs/text_input.dart';

import '../design/app_text.dart';
import '../models/user_model.dart';
import '../widgets/app_alerts.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final _auth = FirebaseAuth.instance;
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _tasks =
      FirebaseFirestore.instance.collection('tasks');
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();

  List<UserModel> users = [];
  UserModel selectedUser = UserModel();

  void getUsers() async {
    final docSnap = await _users
        .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel user, options) => user.toFirestore(),
        )
        .get();

    final data =
        docSnap.docs.where((doc) => doc.id != _auth.currentUser?.uid).toList();
    setState(() {
      users = data.map((doc) {
        UserModel userData = doc.data();
        userData.uid = doc.id;
        return userData;
      }).toList();
      selectedUser = users[0];
    });
  }

  int importance = 1;

  void addTask() {
    NotificationService notificationService = NotificationService();

    TaskModel newTask = TaskModel(
      title: _titleController.text,
      description: _descriptionController.text,
      importance: importance,
      user: selectedUser,
      isCompleted: false,
      // dueDate: _dueDateController.text,
      dueDate: Timestamp.fromDate(DateInput.date!),
      createdAt: Timestamp.now(),
    );

    _tasks
        .withConverter(
          fromFirestore: TaskModel.fromFirestore,
          toFirestore: (TaskModel task, options) => task.toFirestore(),
        )
        .add(newTask)
        .then((value) => {
              Navigator.pop(context),
              AppAlerts.toast(message: "Görev başarıyla oluşturuldu."),
              notificationService.create(_auth.currentUser?.uid, selectedUser.uid, value.id, "Yeni görev atandı!", true),
            });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
    _dateTime=now;
  }


  DateTime now = DateTime.now();
  DateTime? _dateTime;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Görev Oluştur")),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: [
              TextInput(
                controller: _titleController,
                label: "Başlık",
                hint: "Görevi tanımlayınız",
              ),
              const SizedBox(height: 24),
              TextInput(
                controller: _descriptionController,
                label: "İçerik",
                hint: "Görevi özetleyiniz",
                maxLines: 5,
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 1,
                    child: DateInput(label: "Son Tarih", initialDate: DateTime.now()),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Görevli Personel", style: AppText.labelSemiBold),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: AppColors.lightPrimary),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                FluentIcons.person_24_regular,
                                color: AppColors.lightPrimary,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                flex: 3,
                                child: DropdownButton(
                                  underline: Container(),
                                  value: selectedUser,
                                  isExpanded: true,
                                  icon: const Icon(
                                    FluentIcons.chevron_down_24_regular,
                                    color: AppColors.lightPrimary,
                                  ),
                                  items: users.map((user) {
                                    return DropdownMenuItem<UserModel>(
                                      value: user,
                                      child: Text(
                                          "${user.firstName!} ${user.lastName!}"),
                                    );
                                  }).toList(),
                                  onChanged: (UserModel? user) {
                                    setState(() {
                                      selectedUser = user!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Görevin Aciliyeti",
                    style: AppText.labelSemiBold,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            importance = 1;
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: AppColors.lightError,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 2,
                              color: importance == 1
                                  ? Colors.black
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            importance = 2;
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: AppColors.lightWarning,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 2,
                              color: importance == 2
                                  ? Colors.black
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            importance = 3;
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: AppColors.lightSuccess,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 2,
                              color: importance == 3
                                  ? Colors.black
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  icon: const Icon(FluentIcons.save_24_regular),
                  onPressed: addTask,
                  label: const Text("Kaydet"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
