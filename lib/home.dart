import 'package:flutter/material.dart';
import 'package:flutter_application_3/add.dart';
import 'package:flutter_application_3/homescreen.dart';
import 'package:flutter_application_3/login/profile.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _searchindex = 0;
  final List<Widget> _widgetList = [
    const Homescreen(),
    const IssueForm(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Seamless Citizen",
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Pacifico',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _searchindex,
        onTap: (index) {
          setState(() {
            _searchindex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/vectors/icons8-home.svg',
              width: 24,
              height: 24,
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box_outlined,
              color: Colors.black,
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.person_4_sharp,
              color: Colors.black,
            ),
            label: '',
          ),
        ],
      ),
      body: _widgetList[
          _searchindex], // Use widgetList to display selected widget
    );
  }
}
