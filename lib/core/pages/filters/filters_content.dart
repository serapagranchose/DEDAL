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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              context.l18n!.filterTime.capitalize(),
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FiltersTimeDisplay(
              time: time,
              onChange: (value) => setState(() {
                time = value;
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              context.l18n!.filterBuget.capitalize(),
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FiltersCostDisplay(
              cost: cost,
              onChange: (value) => setState(() {
                cost = value;
              }),
            ),
          ),
          Expanded(
            flex: 10,
            child: FiltersDisplay(
              onTap: (filter) => putInside(filter),
              filters: widget.filters,
              selected: currentSelected,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 128),
            child: CustomStringButton(
              disabled: (cost == 0 ||
                  time == 0 ||
                  currentSelected.isNull ||
                  currentSelected!.isEmpty),
              backgroundColor: SharedColorPalette().secondary,
              border: Border.all(
                width: 2,
                color: SharedColorPalette().mainDisable(Theme.of(context)),
              ),
              context: context,
              text: context.l18n!.globalValidate.capitalize(),
              onTap: (controller) async => widget.submit.call(Info(
                  filter: currentSelected,
                  budget: cost.round(),
                  time: time.round())),
            ),
          ),
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
