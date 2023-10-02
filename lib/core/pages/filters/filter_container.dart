import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:dedal/core/models/filter.dart';
import 'package:flutter/material.dart';

class FilterContainer extends StatelessWidget {
  FilterContainer({
    required this.filter,
    required this.onTap,
    required this.selected,
  });

  final Filter filter;
  final bool selected;
  final void Function(Filter filter) onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: !selected
                  ? SharedColorPalette().mainDisable
                  : SharedColorPalette().main,
            ),
            height: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  (filter.name ?? '').capitalize(),
                  style: const TextStyle(color: Colors.white),
                )),
              ],
            )),
        onTap: () => onTap(filter),
      );
}
