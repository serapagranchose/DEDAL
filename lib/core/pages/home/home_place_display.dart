import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/pages/location_detail/location_place_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePlaceDisplay extends StatelessWidget {
  const HomePlaceDisplay({
    super.key,
    required this.place,
  });

  final Place place;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 4,
                spreadRadius: 4,
              ),
            ],
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: AspectRatio(
          aspectRatio: 2,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        switch (place.type) {
                          'Art et culture' => 'assets/images/filters/art.jpg',
                          'Bar et brasserie' => 'assets/images/filters/bar.png',
                          'Divertissement' =>
                            'assets/images/filters/divertissement.jpg',
                          'Shopping' => 'assets/images/filters/shopping.jpg',
                          'Café' => 'assets/images/filters/cafe.png',
                          'Parc et espace vert' =>
                            'assets/images/filters/parc.jpg',
                          'Histoire' =>
                            'assets/images/filters/histoire_lille.jpg',
                          'Restaurant' =>
                            'assets/images/filters/restaurant.png',
                          'Bien-être' => 'assets/images/filters/bien-etre.jpg',
                          'Enfant' => 'assets/images/filters/enfant.png',
                          _ => 'assets/images/filters/divertissement.jpg',
                        },
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Text(
                        place.name ?? 'name',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          place.description ?? 'description',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () => context.pushNamed(
                                LocationPlaceDetailScreen.name,
                                pathParameters: {'id': place.id!}),
                            child: const Text(
                              "Plus d'info >",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
