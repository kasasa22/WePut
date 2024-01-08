import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maker/models/task.dart';
import '../services/task.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final TaskService taskService = TaskService();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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
            _addTaskForm(),
          ],
        ),
      ),
    );
  }

  Widget _tasksListView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
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

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              Task task = tasks[index].data();
              String key = tasks[index].id;

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: ListTile(
                  tileColor: Colors.amber,
                  title: Text(task.comments?[1] ?? ''),
                  subtitle: Text(key),
                  trailing: Checkbox(
                    value: false,
                    onChanged: (value) {
                      Task updateTask = task.copyWith();
                      taskService.updateTask(key, updateTask);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _addTaskForm() {
    return Column(
      children: [
        TextField(
          controller: titleController,
          decoration: const InputDecoration(labelText: 'Title'),
        ),
        TextField(
          controller: descriptionController,
          decoration: const InputDecoration(labelText: 'Description'),
        ),
        ElevatedButton(
          onPressed: () {
            _addTask();
          },
          child: const Text('Add Task'),
        ),
      ],
    );
  }

  void _addTask() {
    Task newTask = Task(
      taskId: 'new_task_id', // You may want to generate a unique ID here
      title: titleController.text,
      description: descriptionController.text,
      dueDate: Timestamp.now(),
      status: 'Not Started',
      assignedUserId: 'assigned_user_id',
      priority: 'Low',
      category: 'General',
      progress: 0,
      comments: ['Comment 1', 'Comment 2'],
      startTime: Timestamp.now(),
      endTime: Timestamp.now(),
      evaluation: 0.0,
    );

    taskService.addTask(newTask);

    // Clear the input fields after adding the task
    titleController.clear();
    descriptionController.clear();
  }
}
