import 'package:flutter/material.dart';

import 'path_animator.dart';

class PathAnimatorScreen extends StatefulWidget {
  const PathAnimatorScreen({super.key});

  @override
  State<PathAnimatorScreen> createState() => _PathAnimatorScreenState();
}

class _PathAnimatorScreenState extends State<PathAnimatorScreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
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
          controller: _controller!,
          maxWidth: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}

class _MyCustomPainter extends CustomPainter {
  _MyCustomPainter({
    required this.controller,
    required this.maxWidth,
  }) : super(repaint: controller);

  final double maxWidth;
  final AnimationController controller;
  final double height = 200;
  final double x = 48;
  final double radius = 80;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final left = x;
    final right = maxWidth - x;
    path.moveTo(left, 0);
    path.lineTo(left, (height * 1) - radius);
    path.arcToPoint(Offset(x + radius, height), radius: Radius.circular(radius), clockwise: false);
    path.lineTo(right - radius, (height * 1));
    path.arcToPoint(Offset(right - radius, height + (radius * 2)), radius: Radius.circular(radius));
    path.lineTo(left + radius, (height + (radius * 2)));
    path.arcToPoint(Offset(left + radius, height + (radius * 4)), radius: Radius.circular(radius), clockwise: false);
    path.lineTo(right - radius, (height + (radius * 4)));
    // path.close();

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
