import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final TaskService taskService = TaskService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Test'),
      ),
      body: StreamBuilder<List<Task>>(
        stream: taskService.getTasksStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return const Text('Error loading tasks');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No tasks available.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var task = snapshot.data![index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteTask(task.taskId),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTask(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _addTask() async {
    await taskService.addTask(Task(
      taskId: '',
      title: 'New Task',
      description: 'Description for the new task.',
      dueDate: Timestamp.now(),
      status: 'pending',
      assignedUserId: 'someUserId',
      priority: 'medium',
      category: 'General',
      progress: 0,
      comments: [],
      startTime: Timestamp.now(),
      endTime: Timestamp.now(),
      evaluation: 0.0,
    ));
  }

  Future<void> _deleteTask(String taskId) async {
    await taskService.deleteTask(taskId);
  }
}
