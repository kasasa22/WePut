import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/task.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final TaskService taskService = TaskService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Test'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _tasksListView(),
          ],
        ),
      ),
    );
  }

  Widget _tasksListView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.8,
      child: StreamBuilder(
        stream: taskService.getTasks(),
        builder: (context, snapshot) {
          List tasks = snapshot.data?.docs ?? [];

          if (tasks.isEmpty) {
            return const Center(
              child: Text('No tasks found'),
            );
          }
          print(tasks.length);

          return const Center();

          // return ListView(
          //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
          //     Map<String, dynamic> data =
          //         document.data()! as Map<String, Object>;
          //     return ListTile(
          //       title: Text(data['title']),
          //       subtitle: Text(data['description']),
          //     );
          //   },
          //   ).toList(),
          // );
        },
      ),
    );
  }
}
