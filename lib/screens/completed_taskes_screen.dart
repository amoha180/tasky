import 'package:flutter/material.dart';

class CompletedTaskesScreen extends StatelessWidget {
  const CompletedTaskesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("Completed Tasks", style: TextStyle(fontSize: 26)),
      ),
    );
    ;
  }
}
