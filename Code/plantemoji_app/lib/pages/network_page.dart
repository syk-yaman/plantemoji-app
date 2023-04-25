import 'package:flutter/material.dart';

import 'dashboard_page.dart';

class NetworkPage extends StatelessWidget {
  const NetworkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundImage(
            imageName: 'images/chartsBack.png',
            child: Padding(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  SizedBox(height: 80),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Network',
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 117, 185),
                            fontWeight: FontWeight.w600,
                            fontSize: 35),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InfoCard(
                    title: 'Jack',
                  ),
                  const SizedBox(height: 20),
                  InfoCard(
                    title: 'Kate',
                  ),
                  const SizedBox(height: 20),
                  InfoCard(
                    title: 'Picard',
                  ),
                  const SizedBox(height: 20),
                  InfoCard(
                    title: 'Jack',
                  )
                ],
              )),
            )));
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String body;

  final String subInfoTitle;
  final String subInfoText;
  final Widget subIcon;

  const InfoCard(
      {required this.title,
      this.body = "Rubber plant, since 2021",
      this.subIcon =
          const Image(image: AssetImage('images/emoji.png'), height: 100),
      this.subInfoText = "Sunlight",
      this.subInfoTitle = "20%",
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              offset: Offset(0, 10),
              blurRadius: 0,
              spreadRadius: 0,
            )
          ],
          gradient: RadialGradient(
            colors: [
              Color.fromARGB(255, 0, 117, 185),
              Color.fromARGB(255, 0, 99, 156)
            ],
            focal: Alignment.topCenter,
            radius: .85,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircleAvatar(
                child: Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 0, 99, 156),
                ),
                backgroundColor: Color.fromARGB(255, 236, 236, 236),
                radius: 25,
              ),
              SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            body,
            style: TextStyle(
                color: Color.fromARGB(255, 248, 255, 143), fontSize: 17),
          ),
          SizedBox(height: 15),
          Container(
            width: double.infinity,
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  subIcon,
                  SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subInfoTitle,
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(subInfoText),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '30%',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Humidity'),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '18c',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Temp'),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
