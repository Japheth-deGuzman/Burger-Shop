import 'package:favorite/screen/account.dart';
import 'package:favorite/screen/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final screens = [
    const MyHomePage(),
    const Account(),
  ];
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: screens[currentindex],
      body: IndexedStack(
        index: currentindex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: BottomNavigationBar(
          onTap: (index) => setState(() => currentindex = index),
          currentIndex: currentindex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.red,
          unselectedItemColor: const Color.fromARGB(146, 0, 0, 0),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          elevation: 50.0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person), label: 'Me'),
          ],
        ),
      ),
    );
  }
}
