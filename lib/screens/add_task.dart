import 'package:flutter/material.dart';

import 'home_screen.dart';

class AddTask extends StatefulWidget {
  AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController taskNameController = TextEditingController();

  TextEditingController taskDescriptionController = TextEditingController();

  GlobalKey<FormState> newTaskKey = GlobalKey<FormState>();

  bool isHighPriority = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffFFFCFC)),
        title: Text(
          "New task",
          style: TextStyle(
            color: Color(0xffFFFCFC),
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Form(
            key: newTaskKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "Task Name",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffFFFCFC),
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: taskNameController,
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? false) {
                              return "Please enter task name";
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Finish UI design for login screen",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xff282828),
                            hintStyle: TextStyle(
                              color: Color(0xff6D6D6D),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Task Description",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffFFFCFC),
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? false) {
                              return "Please enter task description";
                            }
                          },
                          controller: taskDescriptionController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText:
                                "Finish onboarding UI and hand off to devs by Thursday.",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xff282828),
                            hintStyle: TextStyle(
                              color: Color(0xff6D6D6D),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "High Priority",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xffFFFCFC),
                              ),
                            ),
                            Switch(
                              value: isHighPriority,
                              activeTrackColor: Color(0xff15B86C),
                              activeThumbColor: Colors.white,
                              onChanged: (value) {
                                setState(() {
                                  isHighPriority = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ElevatedButton.icon(
                  onPressed: () {
                    if (newTaskKey.currentState?.validate() ?? false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    }
                  },
                  label: Text(
                    "Add Task",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  icon: Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 50),
                    foregroundColor: Color(0xffFFFCFC),
                    backgroundColor: Color(0xff15B86C),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
