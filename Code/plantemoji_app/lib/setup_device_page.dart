import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:plantemoji_app/FakeAPI.dart';
import 'assets/app_colors.dart';
import 'home_page.dart';
import 'models/plant_species.dart';

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
                      image: AssetImage('images/deviceSetup.png'), height: 100),
                  SizedBox(height: 15),
                  Text('Setup a Plantemoji device',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.blueFont,
                          fontSize: 18)),
                  SizedBox(height: 30),
                  Text('What is your plant species?',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: AppColors.greyFont,
                          fontSize: 14)),
                  PlantSpeciesSelector(),
                ]),
          ),
          PageViewModel(
            title: '',
            bodyWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Image(
                      image: AssetImage('images/deviceSetup.png'), height: 100),
                  const SizedBox(height: 15),
                  const Text('Setup a Plantemoji device',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.blueFont,
                          fontSize: 18)),
                  const SizedBox(height: 20),
                  Image(
                      image: AssetImage(FakeAPI.speciesList
                          .elementAt(box.get('selectedSpecies'))
                          .imageLink),
                      height: 145),
                  Text(
                      FakeAPI.speciesList
                          .elementAt(box.get('selectedSpecies'))
                          .name,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: AppColors.greyFont,
                          fontSize: 14)),
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
          //box.put('introduction', false);
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

class PlantSpeciesSelector extends StatefulWidget {
  const PlantSpeciesSelector({super.key});

  @override
  State<PlantSpeciesSelector> createState() => _PlantSpeciesSelectorState();
}

class _PlantSpeciesSelectorState extends State<PlantSpeciesSelector> {
  PlantSpecies selectedSpecies = FakeAPI.speciesList.first;

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('');

    return Column(children: [
      const SizedBox(height: 20),
      Image(image: AssetImage(selectedSpecies.imageLink), height: 145),
      DropdownButton<PlantSpecies>(
        value: selectedSpecies,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        style: const TextStyle(color: AppColors.greyFont),
        underline: Container(
          height: 2,
          color: AppColors.blueFont,
        ),
        onChanged: (PlantSpecies? value) {
          // This is called when the user selects an item.
          setState(() {
            selectedSpecies = value!;
            box.put('selectedSpecies', value.id);
          });
        },
        items: FakeAPI.speciesList
            .map<DropdownMenuItem<PlantSpecies>>((PlantSpecies value) {
          return DropdownMenuItem<PlantSpecies>(
            value: value,
            child: Text(value.name),
          );
        }).toList(),
      ),
    ]);
  }
}
