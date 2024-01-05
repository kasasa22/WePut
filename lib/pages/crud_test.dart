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
        child: Column(children: [
          _tasksListView(),
        ]),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => _addTask(),
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  Widget _tasksListView() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.8,
      width: MediaQuery.sizeOf(context).width * 0.8,
    );
  }

  // Future<void> _addTask() async {
  //   await taskService.addTask(Task(
  //     taskId: '',
  //     title: 'New Task',
  //     description: 'Description for the new task.',
  //     dueDate: Timestamp.now(),
  //     status: 'pending',
  //     assignedUserId: 'someUserId',
  //     priority: 'medium',
  //     category: 'General',
  //     progress: 0,
  //     comments: [],
  //     startTime: Timestamp.now(),
  //     endTime: Timestamp.now(),
  //     evaluation: 0.0,
  //   ));
  // }

  // Future<void> _deleteTask(String taskId) async {
  //   await taskService.deleteTask(taskId);
  // }
}
