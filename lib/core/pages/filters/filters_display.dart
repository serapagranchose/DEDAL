import 'package:dedal/core/models/filter.dart';
import 'package:dedal/core/pages/filters/filter_container.dart';
import 'package:flutter/material.dart';

class FiltersDisplay extends StatelessWidget {
  const FiltersDisplay({
    super.key,
    required this.onTap,
    required this.filters,
    required this.selected,
  });

  final void Function(Filter filter) onTap;
  final List<Filter> filters;
  final List<String>? selected;

  @override
  Widget build(BuildContext context) => GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      physics: const BouncingScrollPhysics(),
      children: filters
          .map((e) => FilterContainer(
                filter: e,
                onTap: (filter) => onTap(filter),
                selected:
                    selected != null ? selected!.contains(e.id ?? '') : false,
              ))
          .toList());
}
