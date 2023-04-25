import 'dart:math';
import 'package:vector_math/vector_math.dart' as Vector;

import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundImageFb1(
            imageUrl:
                'https://firebasestorage.googleapis.com/v0/b/flutterbricks-1926c.appspot.com/o/images%2Fwidgets%2F1634411682152%2FScreen%20Shot%202021-10-16%20at%203.14.09%20PM.png?alt=media&token=ec556af9-6dff-4020-a530-2b1eec58dafe',
            child: SizedBox(
              height: 200,
              width: 200,
              child: WaterProgress(),
            )));
  }
}

class BackgroundImageFb1 extends StatelessWidget {
  final Widget child;
  final String imageUrl;
  const BackgroundImageFb1(
      {required this.child, required this.imageUrl, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Place as the child widget of a scaffold
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 40.0),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Center(child: Image.asset('images/drop.png')),
              Center(
                child: AnimatedBuilder(
                  animation: CurvedAnimation(
                      parent: animationController, curve: Curves.easeInOut),
                  builder: (context, child) => ClipPath(
                    child: Image.asset('images/drop-blue.png'),
                    clipper: WaveClipper(
                        progress,
                        (progress > 0.0 && progress < 1.0)
                            ? animationController.value
                            : 0.0),
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
                          color: Color.fromARGB(255, 0, 78, 122).withAlpha(200),
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold),
                    ),
                    ShadowText(
                      '$current ml',
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
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    '${(target - current < 0 ? 0 : target - current)} ml',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Expanded(
                child: Column(
              children: <Widget>[
                Text(
                  '$target ml',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                )
              ],
            ))
          ],
        ),
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
