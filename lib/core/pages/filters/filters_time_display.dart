import 'package:dedal/core/pages/filters/filters_settings_container.dart';
import 'package:flutter/material.dart';

class FiltersTimeDisplay extends StatelessWidget {
  const FiltersTimeDisplay({
    super.key,
    required this.time,
    required this.onChange,
  });

  final double time;
  final void Function(double value) onChange;
  static List list =
      List.generate(9, (index) => double.parse((index + 1).toString()));

  formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  String doubleToString(double value) {
    if (value % 1 == 0.0) return ('${value.round().toString()}h');
    return ('${value.round().toString()}h30');
  }

  @override
  Widget build(BuildContext context) => ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: list
            .map((e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: FiltersSettingsContainer(
                    label: doubleToString(e),
                    action: () => onChange.call(e),
                    active: e == time,
                  ),
            ))
            .toList(),
      );
}
