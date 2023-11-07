import 'package:dedal/components/button/custom_button.dart';
import 'package:dedal/constants/colors.dart';
import 'package:dedal/constants/enum/filter_page_enum.dart';
import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:dedal/core/models/filter.dart';
import 'package:dedal/core/models/info.dart';
import 'package:dedal/core/pages/filters/filters_cost_display.dart';
import 'package:dedal/core/pages/filters/filters_display.dart';
import 'package:dedal/core/pages/filters/filters_time_display.dart';
import 'package:flutter/material.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class FilterContent extends StatefulWidget {
  const FilterContent({
    super.key,
    required this.filters,
    required this.info,
    required this.submit,
  });

  final List<Filter> filters;
  final void Function(Info info) submit;
  final Info? info;
  @override
  FilterContentState createState() => FilterContentState();
}

class FilterContentState extends State<FilterContent> {
  FilterPageEnum page = FilterPageEnum.filter;

  late List<String>? currentSelected;
  late double cost;
  late double time;

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
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.list,
                        color: SharedColorPalette().main,
                      ),
                      onPressed: () => setState(() {
                            page = FilterPageEnum.filter;
                          })),
                  IconButton(
                      icon: Icon(
                        Icons.attach_money,
                        color: SharedColorPalette().main,
                      ),
                      onPressed: () => setState(() {
                            page = FilterPageEnum.cost;
                          })),
                  IconButton(
                      icon: Icon(
                        Icons.watch_later_outlined,
                        color: SharedColorPalette().main,
                      ),
                      onPressed: () => setState(() {
                            page = FilterPageEnum.time;
                          })),
                ],
              )),
          Expanded(
              flex: 9,
              child: switch (page) {
                FilterPageEnum.cost => FiltersCostDisplay(
                    cost: cost,
                    onChange: (value) => setState(() {
                      cost = value;
                    }),
                  ),
                FilterPageEnum.time => FiltersTimeDisplay(
                    time: time,
                    onChange: (value) => setState(() {
                      time = value;
                    }),
                  ),
                FilterPageEnum.filter => FiltersDisplay(
                    onTap: (filter) => putInside(filter),
                    filters: widget.filters,
                    selected: currentSelected,
                  ),
              }),
          Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomStringButton(
                      context: context,
                      text: context.l18n!.globalReset.capitalize(),
                      onTap: (controller) async => setState(() {
                        cost = 0;
                        time = 0;
                        currentSelected = [];
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomStringButton(
                      context: context,
                      text: context.l18n!.globalValidate.capitalize(),
                      onTap: (controller) async => widget.submit.call(Info(
                          filter: currentSelected,
                          budget: cost.round(),
                          time: time.round())),
                    ),
                  ),
                ],
              )),
        ],
      );

  @override
  void initState() {
    currentSelected = widget.info?.filter ?? [];
    cost = (widget.info?.budget ?? 0).toDouble();
    time = (widget.info?.time ?? 0).toDouble();
    super.initState();
  }
}
