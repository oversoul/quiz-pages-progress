import 'dart:math';

import 'package:flutter/material.dart';

class PercentProgress extends StatefulWidget {
  final double endValue;
  final double initialValue;
  final Function? onSubmit;

  const PercentProgress({
    Key? key,
    required this.initialValue,
    required this.endValue,
    this.onSubmit,
  }) : super(key: key);

  @override
  State<PercentProgress> createState() => _CircleProgressState();
}

class _CircleProgressState extends State<PercentProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController progressController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = Tween(begin: widget.initialValue, end: widget.endValue)
        .animate(progressController)
      ..addListener(() {
        setState(() {});
      });

    progressController.forward();
  }

  @override
  void dispose() {
    animation.removeListener(() {});
    progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      CustomPaint(
        // this will add custom painter after child
        foregroundPainter: CircleProgress(animation.value),
        child: SizedBox(
          width: 200,
          height: 200,
          child: Center(
            child: Text(
              "${animation.value.toInt()}%",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      TextButton(
        onPressed: () {
          if (widget.onSubmit != null) widget.onSubmit!();
        },
        child: const Text("continue..."),
      ),
    ]);
  }
}

class CircleProgress extends CustomPainter {
  double currentProgress;

  CircleProgress(this.currentProgress);

  @override
  void paint(Canvas canvas, Size size) {
    //this is base circle
    Paint outerCircle = Paint()
      ..strokeWidth = 10
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
      ..strokeWidth = 10
      ..color = Colors.redAccent
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 10;

    canvas.drawCircle(
        center, radius, outerCircle); // this draws main outer circle

    double angle = 2 * pi * (currentProgress / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, completeArc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
