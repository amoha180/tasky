import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/Widgets/tasks_list.dart';

import '../Models/taskModel.dart';

class TaskesScreen extends StatefulWidget {
  const TaskesScreen({super.key});

  @override
  State<TaskesScreen> createState() => _TaskesScreenState();
}

class _TaskesScreenState extends State<TaskesScreen> {
  List<Taskmodel> tasks = [];
  bool isLoading = false;

  void initState() {
    super.initState();
    _loadtask();
  }

  void _loadtask() async {
    setState(() {
      isLoading = true;
    });
    final pref = await SharedPreferences.getInstance();
    final finaltaske = pref.getString("tasks");
    if (finaltaske != null) {
      final taskdecodeafter = jsonDecode(finaltaske) as List<dynamic>;
      final tasks = taskdecodeafter
          .map((e) => Taskmodel.fromJson(e))
          .where((e) => e.isDone == false)
          .toList();
      setState(() {
        this.tasks = tasks;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff15B86C),
                    backgroundColor: Colors.white,
                  ),
                )
              : TasksListWidget(
                  tasks: tasks,
                  ontap: (bool? value, int? index) async {
                    setState(() {
                      tasks[index!].isDone = value ?? false;
                    });
                    final pref = await SharedPreferences.getInstance();
                    final updatedTaskes = tasks.map((e) => e.toJson()).toList();
                    pref.setString("tasks", jsonEncode(updatedTaskes));
                    _loadtask();
                  }, emptymessage: 'No Tasks',
                ),
        ),
      ),
    );
  }
}
