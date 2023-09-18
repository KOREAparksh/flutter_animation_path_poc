import 'package:flutter/material.dart';

import 'path_animator.dart';

class PathAnimatorScreen extends StatefulWidget {
  const PathAnimatorScreen({super.key});

  @override
  State<PathAnimatorScreen> createState() => _PathAnimatorScreenState();
}

class _PathAnimatorScreenState extends State<PathAnimatorScreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  final treasureCount = 5;
  final double x = 48;
  final double height = 200;
  final double radius = 80;
  late final double maxWidth;

  final path = Path();

  void initPath() {
    maxWidth = MediaQuery.of(context).size.width;
    final left = x;
    final right = maxWidth - x;
    path.moveTo(left, 0);
    //init treasure
    path.lineTo(left, (height * 1) - radius);

    //first wave
    path.arcToPoint(Offset(x + radius, height * 1), radius: Radius.circular(radius), clockwise: false);
    path.lineTo(right - radius, (height * 1));
    path.arcToPoint(Offset(right - radius, height + (radius * 2)), radius: Radius.circular(radius));
    path.lineTo(left + radius, (height + (radius * 2)));
    path.arcToPoint(Offset(left, height + (radius * 3)), radius: Radius.circular(radius), clockwise: false);

    //second wave
    path.arcToPoint(Offset(x + radius, height + radius * 4), radius: Radius.circular(radius), clockwise: false);
    path.lineTo(right - radius, height + radius * 4);
    path.arcToPoint(Offset(right - radius, height + (radius * 6)), radius: Radius.circular(radius));
    path.lineTo(left + radius, (height + (radius * 6)));
    path.arcToPoint(Offset(left, height + (radius * 7)), radius: Radius.circular(radius), clockwise: false);
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initPath();
      _controller!.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("path animator"),
      ),
      body: CustomPaint(
        painter: _MyCustomPainter(
          path: path,
          controller: _controller!,
        ),
      ),
    );
  }
}

class _MyCustomPainter extends CustomPainter {
  _MyCustomPainter({
    required this.controller,
    required this.path,
  }) : super(repaint: controller);

  final Path path;
  final AnimationController controller;

  @override
  void paint(Canvas canvas, Size size) {
    // draw graph
    final animatedPath = PathAnimator.build(
      path: path,
      animationPercent: controller.value,
    );

    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12.0;

    canvas.drawPath(animatedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
