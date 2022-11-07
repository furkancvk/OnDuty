import 'package:flutter/material.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({Key? key}) : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreen();
}

class _EditTaskScreen extends State<EditTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Task Screen"),
        ),
        body: Column(
          children: const [
            Text("Edit Task Screen"),
          ],
        ),
      ),
    );
  }
}
