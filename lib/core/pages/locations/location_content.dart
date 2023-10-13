import 'package:dedal/components/button/button.dart';
import 'package:dedal/constants/enum/location_page_enum.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/pages/locations/location_list_display.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
                      icon: const Icon(Icons.list),
                      onPressed: () => setState(() {
                            page = LocationPageEnum.parcours;
                          })),
                  IconButton(
                      icon: const Icon(Icons.attach_money),
                      onPressed: () => setState(() {
                            page = LocationPageEnum.liked;
                          })),
                  IconButton(
                      icon: const Icon(Icons.watch_later_outlined),
                      onPressed: () => setState(() {
                            page = LocationPageEnum.close;
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
              onTap: print,
              //   text: page == LocationPageEnum.parcours
              // ? 'Retirer'
              // : 'Ajouter',
            ),
          ),
          Expanded(
              flex: 3,
              child: Column(
                //data.$1.info?.filter
                children: [
                  GlobalButton(
                    text: 'Valider',
                    onTap: () => widget.submit.call(widget.list?.$1),
                  ),
                ],
              )),
          const Gap(20),
        ],
      );

  // ListView(
  //       children: widget.list?.$1?.map((e) => Text(e.name ?? '')).toList() ??
  //           [const Text('no list found')],
  //     );
}
