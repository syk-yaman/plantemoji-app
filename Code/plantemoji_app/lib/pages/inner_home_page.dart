import 'package:flutter/material.dart';
import 'package:plantemoji_app/pages/dashboard_page.dart';

import 'charts_page.dart';
import 'network_page.dart';

class InnerHomePage extends StatefulWidget {
  const InnerHomePage({super.key});

  @override
  State<InnerHomePage> createState() => _InnerHomePageState();
}

class _InnerHomePageState extends State<InnerHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    DashboardPage(),
    ChartsPage(),
    NetworkPage(),
    Center(
      child: Column(children: const [
        SizedBox(
          height: 100,
        ),
        Text(
          'Plantemoji v3',
          style: optionStyle,
        ),
        Text(
          'version 3.0',
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          height: 100,
        ),
        Text(
          'yaman-ka.com',
          style: TextStyle(fontSize: 15),
        ),
      ]),
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
            backgroundColor: Color.fromARGB(255, 0, 117, 185),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Network',
            backgroundColor: Color.fromARGB(255, 0, 117, 185),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
            backgroundColor: Color.fromARGB(255, 0, 117, 185),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 251, 255, 0),
        onTap: _onItemTapped,
      ),
    );
  }
}
