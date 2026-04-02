import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/screens/completed_taskes_screen.dart';
import 'package:tasky/screens/home_screen.dart';
import 'package:tasky/screens/profile_screen.dart';
import 'package:tasky/screens/taskes_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> _screens = [
    HomeScreen(),
    TaskesScreen(),
    CompletedTaskesScreen(),
    ProfileScreen(),
  ];

  int curruntIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int? index) {
          setState(() {
            curruntIndex = index!;
          });
        },
        backgroundColor: Color(0xff181818),
        type: BottomNavigationBarType.fixed,
        currentIndex: curruntIndex,
        selectedItemColor: Color(0xff15B86C),
        unselectedItemColor: Color(0xffC6C6C6),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "Assets/Images/Home.svg",
              colorFilter: curruntIndex == 0
                  ? ColorFilter.mode(Color(0xff15B86C), BlendMode.srcIn)
                  : ColorFilter.mode(Color(0xffC6C6C6), BlendMode.srcIn),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "Assets/Images/Taskes.svg",
              colorFilter: curruntIndex == 1
                  ? ColorFilter.mode(Color(0xff15B86C), BlendMode.srcIn)
                  : ColorFilter.mode(Color(0xffC6C6C6), BlendMode.srcIn),
            ),
            label: "To do",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "Assets/Images/Completed_Taskes.svg",
              colorFilter: curruntIndex == 2
                  ? ColorFilter.mode(Color(0xff15B86C), BlendMode.srcIn)
                  : ColorFilter.mode(Color(0xffC6C6C6), BlendMode.srcIn),
            ),
            label: "Completed",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "Assets/Images/Profile.svg",
              colorFilter: curruntIndex == 3
                  ? ColorFilter.mode(Color(0xff15B86C), BlendMode.srcIn)
                  : ColorFilter.mode(Color(0xffC6C6C6), BlendMode.srcIn),
            ),
            label: "Profile",
          ),
        ],
      ),
      body: _screens[curruntIndex],
    );
  }
}
