import 'package:flutter/material.dart';

class Filter {
  Filter({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Filter.fromJson(Map<String, Object?> json) => Filter(
        id: json['id']?.toString(),
        name: json['name']?.toString(),
      );

  IconData getIcon() => switch ((name ?? '').split(' ')[0].split('-')[0]) {
        'Art' => Icons.brush,
        'Bar' => Icons.sports_bar,
        'Divertissement' => Icons.confirmation_num,
        'Shopping' => Icons.shopping_bag,
        'Restaurant' => Icons.restaurant,
        'Bien' => Icons.spa,
        'Cafe' => Icons.coffee,
        'Parc' => Icons.park,
        'Histoire' => Icons.museum,
        'Enfant' => Icons.child_friendly,
        _ => Icons.check_box_outline_blank,
      };
}
