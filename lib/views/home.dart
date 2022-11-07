import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Home Screen"),
        ),
        body: Column(
          children: [
            const Text("Home Screen"),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "new_task_screen"),
              child: const Text("New Task"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "edit_task_screen"),
              child: const Text("Edit Task"),
            ),
          ],
        ),
      ),
    );
  }
}
