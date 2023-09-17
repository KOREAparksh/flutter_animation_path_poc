import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/material.dart';

class CurvedProgressBar extends StatefulWidget {
  const CurvedProgressBar({super.key});

  @override
  State<CurvedProgressBar> createState() => _CurvedProgressBarState();
}

class _CurvedProgressBarState extends State<CurvedProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("curved progress bar")),
      body: SizedBox(
        width: 200,
        height: 200,
        child: CurvedCircularProgressIndicator(
          value: 0.5,
          strokeWidth: 12,
          animationDuration: Duration(seconds: 1),
          backgroundColor: Color(0xFFFFFFCD),
          color: Colors.blue,
        ),
      ),
    );
  }
}
