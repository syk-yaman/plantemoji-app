import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'introduction_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('');

    // bool firstTimeState = box.get('introduction') ?? true;
    bool firstTimeState = true;

    return firstTimeState
        ? const IntroductionPage()
        : Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text('Your Home Page'),
            ),
          );
  }
}
