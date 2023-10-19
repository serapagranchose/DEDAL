import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/models/place.dart';
import 'package:flutter/material.dart';

class HomePlaceDisplay extends StatelessWidget {
  const HomePlaceDisplay({
    super.key,
    required this.place,
  });

  final Place place;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
              color: SharedColorPalette().main,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: AspectRatio(
            aspectRatio: 1.5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    place.name ?? 'name',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    place.description ?? 'description',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
