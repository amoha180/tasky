import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/taskModel.dart';


class TasksListWidget extends StatelessWidget {
  List<Taskmodel> tasks = [];
  Function(bool?,int?) ontap;
  String emptymessage;

  TasksListWidget({required this.tasks,required this.ontap ,required this.emptymessage,super.key});

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(
      child: Text(
        emptymessage,
        style: TextStyle(color: Colors.white, fontSize: 26),
      ),
    )
        : ListView.builder(
      itemCount: tasks.length,
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
                value: tasks[index].isDone,
                onChanged: (bool? value){
                  ontap(value,index);
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
                      tasks[index].taskName,
                      style: TextStyle(
                        color: tasks[index].isDone
                            ? Color(0xffA0A0A0)
                            : Color(0xffFFFCFC),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        decoration: tasks[index].isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    if(tasks[index].taskDescription.isNotEmpty)
                      Text(
                        tasks[index].taskDescription,
                        style: TextStyle(
                          color: tasks[index].isDone
                              ? Color(0xffA0A0A0)
                              : Color(0xffFFFCFC),
                          fontSize: 14,
                          decoration: tasks[index].isDone
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
    );
  }
}
