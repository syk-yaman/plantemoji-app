import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'assets/app_colors.dart';
import 'home_page.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class SetupDevicePage extends StatelessWidget {
  const SetupDevicePage({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('');

    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: '',
            bodyWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Image(
                      image: AssetImage('images/deviceSetup.png'), height: 120),
                  SizedBox(height: 15),
                  Text('Setup a Plantemoji device',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.blueFont,
                          fontSize: 18)),
                  SizedBox(height: 40),
                  Text('Please select your plant species:',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: AppColors.greyFont,
                          fontSize: 15)),
                  DropdownButtonExample()
                ]),
          ),
          PageViewModel(
            title: '',
            bodyWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Image(
                      image: AssetImage('images/plantemoji.png'), height: 250),
                  const Text('Your plant will be able to:',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: AppColors.blueFont,
                          fontSize: 20)),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            '•  Express its health status using Emojis. \n•  Water '
                            'itself! \n•  Join a social network of other plants.',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: AppColors.greyFont,
                                fontSize: 16),
                            textAlign: TextAlign.start)),
                  )
                ]),
          ),
          PageViewModel(
            title: '',
            bodyWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Image(
                      image: AssetImage('images/plantemoji.png'), height: 250),
                  const Text('Select an option to start:',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: AppColors.blackFont,
                          fontSize: 20)),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Column(children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            minimumSize: const Size(180, 40)),
                        child: const Text('I have a Plantemoji device'),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            minimumSize: const Size(197, 40)),
                        child: const Text('I want to explore the app'),
                      )
                    ]),
                  )
                ]),
          ),
        ],
        onDone: () {
          box.put('introduction', false);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const HomePage();
              },
            ),
          );
        },
        skip: const Icon(Icons.skip_next),
        next: const Icon(Icons.arrow_forward_ios),
        back: const Icon(Icons.arrow_back_ios_new),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        showDoneButton: false,
        showBackButton: true,
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Colors.blue,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
