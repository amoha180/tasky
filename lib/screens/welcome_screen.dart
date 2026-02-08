import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/screens/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181818),
      appBar: AppBar(
        backgroundColor: Color(0xff181818),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("Assets/Images/logo.svg", height: 42, width: 42),
            SizedBox(width: 16),
            Text("Tasky", style: TextStyle(color: Colors.white, fontSize: 28)),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome To Tasky ",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    SvgPicture.asset(
                      "Assets/Images/waving-hand.svg",
                      height: 28,
                      width: 28,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "Your productivity journey starts here.",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 24),
                SvgPicture.asset(
                  "Assets/Images/Work-in-progress.svg",
                  width: 215,
                  height: 204,
                ),
                SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Full Name",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffFFFCFC),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? false) {
                            return "Please enter your name";
                          }
                        },
                        controller: _controller,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "e.g. Sarah Khalid",
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
                    ],
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    if (_key.currentState?.validate() ?? false) {
                      final pref = await SharedPreferences.getInstance();
                      await pref.setString("username", _controller.value.text);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(345, 40),
                    foregroundColor: Color(0xffFFFCFC),
                    backgroundColor: Color(0xff15B86C),
                  ),
                  child: Text(
                    "Let’s Get Started",
                    style: TextStyle(fontWeight: FontWeight.bold),
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
