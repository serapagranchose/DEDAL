import 'package:dedal/core/models/filter.dart';
import 'package:dedal/core/pages/filters/filter_container.dart';
import 'package:flutter/material.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class FilterDisplay extends StatefulWidget {
  const FilterDisplay({
    super.key,
    required this.filters,
    required this.selected,
  });

  final List<Filter> filters;
  final List<String>? selected;
  @override
  FilterDisplayState createState() => FilterDisplayState();
}

class FilterDisplayState extends State<FilterDisplay> {
  void putInside(Filter filter) {
    if (widget.selected.isNull || filter.id.isNull) {
      return;
    }
    if (widget.selected!.contains(filter.id)) {
      setState(() {
        widget.selected!.removeAt(widget.selected!.indexOf(filter.id ?? ''));
      });
    } else {
      setState(() {
        widget.selected!.add(filter.id!);
      });
    }
  }

  @override
  Widget build(BuildContext context) => GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      physics: const BouncingScrollPhysics(),
      children: widget.filters
          .map((e) => FilterContainer(
                filter: e,
                onTap: (filter) => putInside(filter),
                selected: widget.selected != null
                    ? widget.selected!.contains(e.id ?? '')
                    : false,
              ))
          .toList());
}
