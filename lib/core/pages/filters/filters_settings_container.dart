import 'package:dedal/constants/colors.dart';
import 'package:flutter/material.dart';

class FiltersSettingsContainer extends StatelessWidget {
  const FiltersSettingsContainer({
    super.key,
    required this.label,
    required this.active,
    required this.action,
  });

  final String label;
  final bool active;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(4),
        child: InkWell(
          onTap: () => action.call(),
          child: AspectRatio(
            aspectRatio: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: active ? SharedColorPalette().secondary : Colors.grey,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(child: Text(label)),
            ),
          ),
        ),
      );
}
