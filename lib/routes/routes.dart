import 'package:flutter/material.dart';
import '../views/login.dart';
import '../views/sign_up.dart';
import '../views/home.dart';
import '../views/new_task.dart';
import '../views/edit_task.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "login_screen": (context) => const LoginScreen(),
  "sign_up_screen": (context) => const SignUpScreen(),
  "home_screen": (context) => const HomeScreen(),
  "new_task_screen": (context) => const NewTaskScreen(),
  "edit_task_screen": (context) => const EditTaskScreen(),
};
