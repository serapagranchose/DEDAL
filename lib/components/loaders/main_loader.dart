import 'package:flutter/material.dart';

class MainLoader extends StatelessWidget {
  const MainLoader({super.key});

  @override
  Widget build(BuildContext context) => const Center(
          child: CircularProgressIndicator(
        color: Color(0xFF5663FF),
        strokeWidth: 8,
      ));
}
