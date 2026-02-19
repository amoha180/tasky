import 'package:flutter/material.dart';
import 'package:tasky/screens/home_screen.dart';
import 'package:tasky/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  String? username = pref.getString("username");
  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.username});

  final String? username;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: username == null ? WelcomeScreen() : HomeScreen(),
    );
  }
}
