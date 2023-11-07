import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:flutter/material.dart';

class APIOfflinePage extends StatelessWidget {
  const APIOfflinePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Text(context.l18n!.globalOffLine.capitalize()),
      );
}
