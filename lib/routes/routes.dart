
import 'package:flutter/material.dart';
import 'package:task_managing_app/views/home.dart';
import 'package:task_managing_app/views/login.dart';
import 'package:task_managing_app/views/new_task.dart';
import 'package:task_managing_app/views/signup.dart';
import 'package:task_managing_app/views/task_details.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "home_screen": (context) => const HomeScreen(),
  "signUp_screen": (context) => const SignUpScreen(),
  "login_screen": (context) => const LoginScreen(),
  "new_task_screen": (context) => const NewTaskScreen(),
  "task_details_screen": (context) => const TaskDetailsScreen(),
};