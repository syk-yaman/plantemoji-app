import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:plantemoji_app/pages/setup_device_page.dart';

import 'pages/home_page.dart';
import 'pages/login_page.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
        routes: <String, WidgetBuilder>{
          'setupDevice': (context) =>
              const SetupDevicePage(title: 'Setup a Device'),
          'loginPage': (context) => const LoginPage(),
        });
  }
}
