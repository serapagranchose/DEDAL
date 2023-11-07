import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class FiltersTimeDisplay extends StatelessWidget {
  const FiltersTimeDisplay({
    super.key,
    required this.time,
    required this.onChange,
  });

  final double time;
  final void Function(double value) onChange;

  formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(context.l18n!.filterTime.capitalize()),
          SleekCircularSlider(
            appearance: CircularSliderAppearance(
                infoProperties: InfoProperties(
                    modifier: (percentage) =>
                        formattedTime(timeInSecond: percentage.round()),
                    mainLabelStyle: const TextStyle(color: Colors.black)),
                customColors: CustomSliderColors(
                    trackColor: SharedColorPalette().mainDisable,
                    progressBarColor: SharedColorPalette().main)),
            initialValue: time,
            min: 0,
            max: 600,
            onChange: (value) => onChange(value),
          ),
        ],
      );
}
