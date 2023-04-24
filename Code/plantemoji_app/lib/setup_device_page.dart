import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:plantemoji_app/FakeAPI.dart';
import 'assets/app_colors.dart';
import 'home_page.dart';
import 'models/plant_species.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/foundation.dart';

class SetupDevicePage extends StatelessWidget {
  const SetupDevicePage({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('');

    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            titleWidget: const SizedBox(height: 0),
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
            titleWidget: const SizedBox(height: 0),
            bodyWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Image(
                      image: AssetImage('images/deviceSetup.png'), height: 100),
                  const SizedBox(height: 10),
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
                      height: 130),
                  const SizedBox(height: 5),
                  Text(
                      FakeAPI.speciesList
                          .elementAt(box.get('selectedSpecies'))
                          .name,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: AppColors.greyFont,
                          fontSize: 14)),
                  const SizedBox(height: 20),
                  const TextFields()
                ]),
          ),
          PageViewModel(
            titleWidget: const SizedBox(height: 0),
            bodyWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Image(
                      image: AssetImage('images/deviceSetup.png'), height: 100),
                  SizedBox(height: 10),
                  Text('Setup a Plantemoji device',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.blueFont,
                          fontSize: 18)),
                  SizedBox(height: 20),
                  SizedBox(height: 240, width: 300, child: QRDetector()),
                  SizedBox(height: 2),
                  Text('Please scan the QR code on your Plantemoji device',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.redFont,
                          fontSize: 12)),
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
  final box = Hive.box('');
  PlantSpecies selectedSpecies = FakeAPI.speciesList
      .elementAt(Hive.box('').get('selectedSpecies', defaultValue: 0));

  @override
  Widget build(BuildContext context) {
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
            Navigator.of(context).popAndPushNamed('setupDevice');
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

class TextFields extends StatefulWidget {
  const TextFields({super.key});

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(
          left: 30,
          right: 30,
        ),
        child: Column(
          children: [
            SizedBox(
                height: 35,
                child: TextField(
                  autofocus: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Your plant nickname!',
                      icon: Icon(Icons.tag_faces_rounded)),
                  controller: _controller,
                  onSubmitted: (String value) async {
                    await showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Thanks!'),
                          content: Text(
                              'You typed "$value", which has length ${value.characters.length}.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                )),
            const SizedBox(height: 10),
            DatePicker()
          ],
        ));
  }
}

class DatePicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DatePickerState();
  }
}

//Taken from https://www.fluttercampus.com/guide/39/how-to-show-date-picker-on-textfield-tap-and-get-formatted-date/
class _DatePickerState extends State<DatePicker> {
  TextEditingController dateinput = TextEditingController();
  //text editing controller for text field

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 35,
        child: Center(
            child: TextField(
          controller: dateinput, //editing controller of this TextField
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              icon: Icon(Icons.calendar_today), //icon of text field
              labelText: "Since when do you have it?" //label text of field
              ),
          readOnly: true, //set it true, so that user will not able to edit text
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(
                    2000), //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(2101));

            if (pickedDate != null) {
              print(
                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              print(
                  formattedDate); //formatted date output using intl package =>  2021-03-16
              //you can implement different kind of Date Format here according to your requirement

              setState(() {
                dateinput.text =
                    formattedDate; //set output date to TextField value.
              });
            } else {
              print("Date is not selected");
            }
          },
        )));
  }
}

class QRDetector extends StatefulWidget {
  const QRDetector({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRDetectorState();
}

class _QRDetectorState extends State<QRDetector> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    //log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
