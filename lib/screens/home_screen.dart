import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/Models/taskModel.dart';

import 'add_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username = "default";
  List<Taskmodel> task = [];
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
    await Future.delayed(Duration(seconds: 5));
    final pref = await SharedPreferences.getInstance();
    final finaltaske = pref.getString("tasks");
    if (finaltaske != null) {
      final taskdecodeafter = jsonDecode(finaltaske) as List<dynamic>;
      final tasks = taskdecodeafter.map((e) => Taskmodel.fromJson(e)).toList();
      setState(() {
        task = tasks;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTask()),
            );
            _loadtask();
          },
        ),
      ),
      backgroundColor: Color(0xff181818),
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
              if (task.isNotEmpty)
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          backgroundColor: Colors.red,
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: task.length,
                          padding: EdgeInsets.only(bottom: 40),
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              alignment: Alignment.center,
                              height: 56,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xff282828),
                              ),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: task[index].isDone,
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        task[index].isDone = value ?? false;
                                      });
                                      final pref =
                                          await SharedPreferences.getInstance();
                                      final updatedTaskes = task
                                          .map((e) => e.toJson())
                                          .toList();
                                      pref.setString(
                                        "tasks",
                                        jsonEncode(updatedTaskes),
                                      );
                                    },
                                    activeColor: Color(0xff15B86C),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(4),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          task[index].taskName,
                                          style: TextStyle(
                                            color: task[index].isDone
                                                ? Color(0xffA0A0A0)
                                                : Color(0xffFFFCFC),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            decoration: task[index].isDone
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          task[index].taskDescription,
                                          style: TextStyle(
                                            color: task[index].isDone
                                                ? Color(0xffA0A0A0)
                                                : Color(0xffFFFCFC),
                                            fontSize: 14,
                                            decoration: task[index].isDone
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.more_vert),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
            ],
          ),
        ),
      ),
    );
  }
}
