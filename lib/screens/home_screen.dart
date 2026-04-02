import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/Models/taskModel.dart';
import 'package:tasky/Widgets/tasks_list.dart';

import 'add_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username = "default";
  List<Taskmodel> tasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loaddata();
    _loadtask();
  }

  void _loaddata() async {
    final pref = await SharedPreferences.getInstance();
    username = pref.getString("username");
    setState(() {});
  }

  void _loadtask() async {
    setState(() {
      isLoading = true;
    });
    final pref = await SharedPreferences.getInstance();
    final finaltaske = pref.getString("tasks");
    if (finaltaske != null) {
      final taskdecodeafter = jsonDecode(finaltaske) as List<dynamic>;
      final tasks = taskdecodeafter.map((e) => Taskmodel.fromJson(e)).toList();
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xff181818),
                    backgroundImage: AssetImage("Assets/Images/Person.png"),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Evening ,${username} ",
                        style: TextStyle(
                          color: Color(0xffFFFCFC),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "Gone task at a time.One step closer.",
                        style: TextStyle(
                          color: Color(0xffFFFCFC),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Spacer(),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: ElevatedButton.icon(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => AddTask()),
              //       );
              //     },
              //     style: ElevatedButton.styleFrom(
              //       fixedSize: Size(168, 40),
              //       backgroundColor: Color(0xff15B86C),
              //       foregroundColor: Color(0xffFFFCFC),
              //     ),
              //     icon: Icon(Icons.add),
              //     label: Text("Add New Task"),
              //   ),
              // ),
              SizedBox(height: 16),
              Text(
                "Yuhuu ,Your work Is",
                style: TextStyle(
                  color: Color(0xffFFFCFC),
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    "almost done ! ",
                    style: TextStyle(
                      color: Color(0xffFFFCFC),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SvgPicture.asset("Assets/Images/waving-hand.svg"),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 16),
                child: Text(
                  "My Taskes",
                  style: TextStyle(
                    color: Color(0xffFFFCFC),
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),

              Expanded(
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
                          final updatedTaskes = tasks
                              .map((e) => e.toJson())
                              .toList();
                          pref.setString("tasks", jsonEncode(updatedTaskes));
                        }, emptymessage: 'No Data',
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 46,
        width: 168,
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(25),
          ),
          label: Text("Add New Task"),
          icon: Icon(Icons.add),
          backgroundColor: Color(0xff15B86C),
          foregroundColor: Color(0xffFFFCFC),
          onPressed: () async {
            final bool result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTask()),
            );
            if (result != null && result) {
              _loadtask();
            }
          },
        ),
      ),
    );
  }
}
