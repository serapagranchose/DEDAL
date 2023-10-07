import 'package:dedal/components/button/button.dart';
import 'package:dedal/core/models/filter.dart';
import 'package:dedal/core/pages/filters/filter_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
  late List<String>? currentSelected;

  void putInside(Filter filter) {
    if (currentSelected.isNull || filter.id.isNull) {
      return;
    }
    if (currentSelected!.contains(filter.id)) {
      setState(() {
        currentSelected!.removeAt(currentSelected!.indexOf(filter.id ?? ''));
      });
    } else {
      setState(() {
        currentSelected!.add(filter.id!);
      });
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Expanded(
              flex: 9,
              child: GridView.count(
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
                            selected: currentSelected != null
                                ? currentSelected!.contains(e.id ?? '')
                                : false,
                          ))
                      .toList())),
          Expanded(
              flex: 3,
              child: Column(
                //data.$1.info?.filter
                children: [
                  GlobalButton(
                    text: 'Valider',
                    onTap: () => print(currentSelected),
                  ),
                  GlobalButton(
                      text: 'Réinitialisé',
                      onTap: () => setState(() {
                            currentSelected = [];
                          })),
                ],
              )),
          const Gap(20),
        ],
      );

  @override
  void initState() {
    currentSelected = widget.selected;
    super.initState();
  }
}
