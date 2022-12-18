import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../design/app_colors.dart';
import '../design/app_text.dart';
import '../models/task.dart';
import '../models/user.dart';
import '../utils/helpers.dart';
import '../widgets/app_cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  final _tasksStream = FirebaseFirestore.instance.collection('tasks').withConverter<TaskModel>(
    fromFirestore: TaskModel.fromFirestore,
    toFirestore: (TaskModel task, options) => task.toFirestore(),
  );
  final CollectionReference _users = FirebaseFirestore.instance.collection('users');
  final TextEditingController _searchController = TextEditingController();

  late bool isAdmin;
  String _searchQuery = "";
  String _displayName = "";

  @override
  void initState() {
    super.initState();
    isAdmin = false;
    setDisplayName();
    setIsAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Ana Sayfa"),
          actions: [
            const Icon(Iconsax.notification),
            const SizedBox(width: 12),
            Stack(
              alignment: Alignment.center,
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage("assets/images/avatar.png"),
                ),
                PopupMenuButton<int>(
                  onSelected: (value) {
                    // if(value == 1) Navigator.pushNamed(context, "help_view");
                    if (value == 4) logOut();
                  },
                  tooltip: "Profil Menüsü",
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Row(
                        children: [
                          const Icon(
                            FluentIcons.person_24_regular,
                            color: AppColors.lightPrimary,
                          ),
                          const SizedBox(width: 10),
                          Text("Profil", style: AppText.contextSemiBold),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Row(
                        children: [
                          const Icon(
                            FluentIcons.settings_24_regular,
                            color: AppColors.lightPrimary,
                          ),
                          const SizedBox(width: 10),
                          Text("Ayarlar", style: AppText.contextSemiBold),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: Row(
                        children: [
                          const Icon(
                            FluentIcons.chat_help_24_regular,
                            color: AppColors.lightPrimary,
                          ),
                          const SizedBox(width: 10),
                          Text("Yardım", style: AppText.contextSemiBold),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 4,
                      child: Row(
                        children: [
                          const Icon(
                            FluentIcons.arrow_exit_20_regular,
                            color: AppColors.lightPrimary,
                          ),
                          const SizedBox(width: 10),
                          Text("Çıkış Yap", style: AppText.contextSemiBold),
                        ],
                      ),
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: const BorderSide(color: AppColors.lightPrimary),
                  ),
                  splashRadius: 20,
                  icon: const Icon(
                    Icons.add,
                    color: Colors.transparent,
                  ),
                  offset: const Offset(0, 44),
                  color: AppColors.lightSecondary,
                  elevation: 0,
                ),
              ],
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
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: _searchController,
                    onChanged: (String value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: const InputDecoration(
                      suffixIcon: Icon(
                        FluentIcons.search_24_filled,
                        color: AppColors.lightPrimary,
                      ),
                      hintText: "Görev Ara...",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightInfo),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(4),
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightPrimary),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(4),
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),
                /*PopupMenuButton<int>(
                  tooltip: "Filtrele",
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 0,
                      ),
                      child: Text("Merhaba"),
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: const BorderSide(color: AppColors.lightPrimary),
                  ),
                  splashRadius: 20,
                  offset: const Offset(9, 37),
                  color: AppColors.lightSecondary,
                  elevation: 0,
                  child: OutlinedButton.icon(
                    onPressed: null,
                    icon: const Icon(
                      FluentIcons.filter_24_regular,
                      color: AppColors.lightPrimary,
                    ),
                    label: const Text(
                      "Filtrele",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                        color: AppColors.lightPrimary,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),*/
              ],
            ),
            const SizedBox(height: 24),
            Text(
              isAdmin ? "Atanan Görevler" : "Görevleriniz",
              style: AppText.titleSemiBold,
            ),
            const SizedBox(height: 16),
            StreamBuilder<QuerySnapshot<TaskModel>>(
                stream: _tasksStream.orderBy('importance', descending: false).orderBy('createdAt', descending: true).snapshots(),
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
                  } else {
                    List tasks = snapshot.data!.docs.map((doc) {
                      TaskModel taskData = doc.data() as TaskModel;
                      taskData.uid = doc.id;
                      return taskData;
                    }).toList();

                    tasks = tasks
                        .where((s) => s.title
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase()))
                        .toList();

                    return Column(
                      children: tasks.map((task) {

                        return Column(
                          children: [
                            AppCards.taskCard(
                              task: task,
                              context: context,
                              itemBuilder: (context) => [
                                if (isAdmin)
                                  PopupMenuItem(
                                    value: 1,
                                    child: Row(
                                      children: [
                                        const Icon(
                                          FluentIcons.edit_24_regular,
                                          color: AppColors.lightPrimary,
                                        ),
                                        const SizedBox(width: 10),
                                        Text("Düzenle",
                                            style: AppText.contextSemiBold),
                                      ],
                                    ),
                                  ),
                                if (isAdmin)
                                  PopupMenuItem(
                                    value: 2,
                                    child: Row(
                                      children: [
                                        const Icon(
                                          FluentIcons.delete_24_regular,
                                          color: AppColors.lightPrimary,
                                        ),
                                        const SizedBox(width: 10),
                                        Text("Sil", style: AppText.contextSemiBold),
                                      ],
                                    ),
                                  ),
                                if (!isAdmin)
                                  PopupMenuItem(
                                    value: 3,
                                    child: Row(
                                      children: [
                                        const Icon(
                                          FluentIcons.check_24_regular,
                                          color: AppColors.lightPrimary,
                                        ),
                                        const SizedBox(width: 10),
                                        Text("Tamamla",
                                            style: AppText.contextSemiBold),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ],
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
                    Navigator.of(context).pushNamed("new_task_screen"),
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
    final docSnap = await _users.withConverter(
      fromFirestore: UserModel.fromFirestore,
      toFirestore: (UserModel user, options) => user.toFirestore(),
    ).doc(_auth.currentUser!.uid).get();

    final currentUser = docSnap.data();

    setState(() {
      isAdmin = (currentUser?.isAdmin ?? false);
    });
  }

  Future<UserModel?> getUser(String id) async {
    final docSnap = await _users.withConverter(
      fromFirestore: UserModel.fromFirestore,
      toFirestore: (UserModel user, options) => user.toFirestore(),
    ).doc(id).get();

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
}
