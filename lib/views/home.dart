import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Home Page"),
        ElevatedButton(
          child: Text("Create Task"),
          onPressed: () {
            Navigator.pushNamed(context, "new_task_screen");
          },
        ),
        ElevatedButton(
          child: Text("Task Details"),
          onPressed: () {
            Navigator.pushNamed(context, "task_details_screen");
          },
        ),

      ],
    );
  }
}
