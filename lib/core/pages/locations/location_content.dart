import 'package:dedal/components/button/custom_button.dart';
import 'package:dedal/constants/colors.dart';
import 'package:dedal/constants/enum/location_page_enum.dart';
import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/pages/locations/location_list_display.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class LocationContent extends StatefulWidget {
  const LocationContent({
    super.key,
    required this.list,
    required this.submit,
  });
  final void Function(List<Place>? place) submit;

  final (List<Place>?, List<Place>?, List<Place>?)? list;
  @override
  LocationContentState createState() => LocationContentState();
}

class LocationContentState extends State<LocationContent> {
  LocationPageEnum page = LocationPageEnum.parcours;

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
                        color: page == LocationPageEnum.parcours
                            ? SharedColorPalette().secondary
                            : SharedColorPalette().lightSecondary,
                      ),
                      onPressed: () => setState(() {
                            page = LocationPageEnum.parcours;
                          })),
                  IconButton(
                      icon: Icon(
                        Icons.location_on_rounded,
                        color: page == LocationPageEnum.close
                            ? SharedColorPalette().secondary
                            : SharedColorPalette().lightSecondary,
                      ),
                      onPressed: () => setState(() {
                            print(page);
                            page = LocationPageEnum.close;
                          })),
                  IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: page == LocationPageEnum.liked
                            ? SharedColorPalette().secondary
                            : SharedColorPalette().lightSecondary,
                      ),
                      onPressed: () => setState(() {
                            page = LocationPageEnum.liked;
                          })),
                ],
              )),
          Expanded(
            flex: 9,
            child: LocationListDisplay(
              list: switch (page) {
                LocationPageEnum.parcours => widget.list?.$1,
                LocationPageEnum.close => widget.list?.$2,
                LocationPageEnum.liked => widget.list?.$3
              },
              action: switch (page) {
                LocationPageEnum.parcours => true,
                LocationPageEnum.close => false,
                LocationPageEnum.liked => false
              },
              supr: page == LocationPageEnum.parcours,
              onTap: (place) {
                if (page == LocationPageEnum.parcours) {
                  setState(() {
                    final target = widget.list?.$1
                        ?.firstWhere((elem) => elem.id == place.id);
                    if (target.isNotNull) {
                      widget.list?.$1?.remove(target);
                      widget.list?.$2?.add(target!);
                    }
                  });
                } else {
                  setState(() {
                    int? target = widget.list?.$1?.indexOf(place);

                    if (target == -1) {
                      widget.list?.$1?.add(place);
                    }
                  });
                }
                context.pop();
              },
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: CustomStringButton(
                      context: context,
                      text: context.l18n!.globalValidate.capitalize(),
                      onTap: (c) async => widget.submit.call(widget.list?.$1),
                    ),
                  ),
                ],
              )),
        ],
      );
}
