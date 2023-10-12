import 'package:dedal/core/models/place.dart';
import 'package:flutter/material.dart';

class HomePlaceDisplay extends StatelessWidget {
  HomePlaceDisplay({
    required this.place,
  });

  final Place place;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          color: Colors.amber,
          child: AspectRatio(
            aspectRatio: 2,
            child: Column(
              children: [
                Text(place.name ?? 'name'),
                Text(place.description ?? 'description'),
                Text(place.duration?.toString() ?? 'duration'),
                Text(place.price?.toString() ?? 'price'),
                Text(place.link?.toString() ?? 'link'),
                Text(place.type?.toString() ?? 'type'),
              ],
            ),
          ),
        ),
      );
}
