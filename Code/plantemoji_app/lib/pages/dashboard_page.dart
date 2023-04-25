import 'dart:math';
import 'package:vector_math/vector_math.dart' as Vector;

import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundImage(
            imageName: 'images/dashBack.png',
            child: Stack(children: <Widget>[
              Positioned(
                  top: -100.0,
                  right: -100.0,
                  child: Image.asset(
                    'images/sun.png',
                    height: 300,
                  )),
              Positioned(right: 20.0, bottom: 180, child: WaterProgress()),
              Positioned(
                  bottom: 160.0,
                  child: Image.asset(
                    'images/happyPlant.png',
                    height: 400,
                  )),
              Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        'images/soil.png',
                        fit: BoxFit.cover,
                      )))
            ])));
  }
}

class BackgroundImage extends StatelessWidget {
  final Widget child;
  final String imageName;
  const BackgroundImage(
      {required this.child, required this.imageName, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Place as the child widget of a scaffold
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageName),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}

//Taken from https://github.com/artur-ios-dev/watermaniac
class WaterProgress extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WaterProgressState();
  }
}

class _WaterProgressState extends State<WaterProgress>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  double current = 400;
  double target = 700;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var percentage = target > 0 ? current / target * 100 : 100.0;
    var progress = (percentage > 100.0 ? 100.0 : percentage) / 100.0;
    progress = 1.0 - progress;

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Center(
                  child: Image.asset(
                'images/waterBucket.png',
                fit: BoxFit.scaleDown,
                width: 120,
              )),
              Center(
                child: AnimatedBuilder(
                  animation: CurvedAnimation(
                      parent: animationController, curve: Curves.easeInOut),
                  builder: (context, child) => ClipPath(
                    clipper: WaveClipper(
                        progress,
                        (progress > 0.0 && progress < 1.0)
                            ? animationController.value
                            : 0.0),
                    child: Image.asset(
                      'images/waterBucketFilled.png',
                      width: 120,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: <Widget>[
                    ShadowText(
                      '${(target > 0 ? current / target * 100 : 100).toStringAsFixed(0)}%',
                      shadowColor: Colors.black.withOpacity(0.5),
                      offsetX: 3.0,
                      offsetY: 3.0,
                      blur: 3.0,
                      style: TextStyle(
                          color:
                              Color.fromARGB(255, 255, 255, 255).withAlpha(200),
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold),
                    ),
                    ShadowText(
                      '${current.toStringAsFixed(0)} ml',
                      shadowColor: Colors.black.withOpacity(0.3),
                      offsetX: 3.0,
                      offsetY: 3.0,
                      blur: 3.0,
                      style: TextStyle(
                          color: Colors.black.withAlpha(150),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const Text(
          'Water Bucket',
          style: TextStyle(
              color: Color.fromARGB(255, 55, 143, 202),
              fontWeight: FontWeight.w600,
              fontSize: 18),
        )
      ],
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double progress;
  final double animation;

  WaveClipper(this.progress, this.animation);

  @override
  Path getClip(Size size) {
    final double wavesHeight = size.height * 0.1;

    var path = new Path();

    if (progress == 1.0) {
      return path;
    } else if (progress == 0.0) {
      path.lineTo(0.0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0.0);
      path.lineTo(0.0, 0.0);
      return path;
    }

    List<Offset> wavePoints = [];
    for (int i = -2; i <= size.width.toInt() + 2; i++) {
      var extraHeight = wavesHeight * 0.5;
      extraHeight *= i / (size.width / 2 - size.width);
      var dx = i.toDouble();
      var dy = sin((animation * 360 - i) % 360 * Vector.degrees2Radians) * 5 +
          progress * size.height -
          extraHeight;
      if (!dx.isNaN && !dy.isNaN) {
        wavePoints.add(Offset(dx, dy));
      }
    }

    path.addPolygon(wavePoints, false);

    // finish the line
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);

    return path;
  }

  @override
  bool shouldReclip(WaveClipper old) =>
      progress != old.progress || animation != old.animation;
}

class ShadowText extends StatelessWidget {
  ShadowText(this.data,
      {required this.style,
      this.textAlign = TextAlign.start,
      this.shadowColor = Colors.black,
      this.offsetX = 2.0,
      this.offsetY = 2.0,
      this.blur = 2.0})
      : assert(data != null);

  final String data;
  final TextStyle style;
  final Color shadowColor;
  final double offsetX;
  final double offsetY;
  final double blur;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      style: style.copyWith(
          // shadows: <Shadow>[
          //   Shadow(
          //     offset: Offset(offsetX, offsetY),
          //     blurRadius: blur,
          //     color: shadowColor,
          //   ),
          // ],
          ),
    );
  }
}
