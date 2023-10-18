import 'package:flutter/material.dart';

class MainLoader extends StatelessWidget {
  const MainLoader({super.key});

  @override
  Widget build(BuildContext context) => const Center(
          child: CircularProgressIndicator(
        color: Color(0xFF5663FF),
        strokeCap: StrokeCap.round,
        strokeWidth: 8,
      ));
}

class PlanLoader extends StatelessWidget {
  const PlanLoader({super.key});

  @override
  Widget build(BuildContext context) =>
      Center(child: Image.asset('assets/loader/loader.gif'));
}
