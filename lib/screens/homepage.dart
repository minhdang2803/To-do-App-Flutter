import 'package:flutter/material.dart';
import 'package:todoapp/screens/screens.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static final List<Widget> page = <Widget>[const SplashScreen(), ListScreen()];
  int _selectedIndex = 0;
  void setPage(int index) => setState(() {
        _selectedIndex = index;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: page[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'New'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple.shade400,
        onTap: setPage,
      ),
    );
  }
}
