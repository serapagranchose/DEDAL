import 'package:dedal/core/models/place.dart';
import 'package:flutter/material.dart';

class LocationListDisplay extends StatelessWidget {
  const LocationListDisplay({
    super.key,
    required this.list,
    required this.onTap,
  });

  final List<Place>? list;
  final void Function(Place place) onTap;

  @override
  Widget build(BuildContext context) => ListView(
        children: list?.map((e) => Text(e.name ?? '')).toList() ??
            [const Text('no list found')],
      );
}
