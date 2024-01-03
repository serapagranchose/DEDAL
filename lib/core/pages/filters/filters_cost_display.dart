import 'package:dedal/constants/colors.dart';
import 'package:flutter/material.dart';

class FiltersCostDisplay extends StatelessWidget {
  const FiltersCostDisplay({
    super.key,
    required this.cost,
    required this.onChange,
  });

  final double cost;
  final void Function(double value) onChange;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: InkWell(
                onTap: () => onChange.call(50),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: cost == 50
                          ? SharedColorPalette().secondary
                          : Colors.grey,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: const Center(child: Text('0€ - 50€')),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: InkWell(
                onTap: () => onChange.call(100),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: cost == 100
                          ? SharedColorPalette().secondary
                          : Colors.grey,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: const Center(child: Text('50€ - 100€')),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: InkWell(
                onTap: () => onChange.call(200),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: cost == 200
                          ? SharedColorPalette().secondary
                          : Colors.grey,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: const Center(child: Text('100€ - 200€')),
                ),
              ),
            ),
          ),
        ],
      );
}
