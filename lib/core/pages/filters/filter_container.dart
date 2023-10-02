import 'package:dedal/components/button/button.dart';
import 'package:dedal/constants/colors.dart';
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
  Widget build(BuildContext context) => GlobalButton(
        text: filter.name,
        color: !selected ? SharedColorPalette().mainDisable : null,
        onTap: () => onTap(filter),
      );
}
