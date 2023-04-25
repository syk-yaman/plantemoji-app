import 'package:flutter/material.dart';
import 'package:plantemoji_app/pages/dashboard_page.dart';

import 'charts_page.dart';

class InnerHomePage extends StatefulWidget {
  const InnerHomePage({super.key});

  @override
  State<InnerHomePage> createState() => _InnerHomePageState();
}

class _InnerHomePageState extends State<InnerHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardPage(),
    ChartsPage(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromARGB(255, 165, 115, 50),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.line_axis_outlined),
            label: 'Charts',
            backgroundColor: Color.fromARGB(255, 146, 44, 124),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 251, 255, 0),
        onTap: _onItemTapped,
      ),
    );
  }
}
