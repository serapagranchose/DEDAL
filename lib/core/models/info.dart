import 'dart:convert';

import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class Info {
  Info({
    this.filter,
    this.time,
    this.budget,
    this.map,
    this.accecibility,
    this.mapName,
  });

  int? time;
  int? budget;
  bool? accecibility;
  List<String>? filter;
  String? mapName;
  Map<String, Object>? map;

  factory Info.toJson(dynamic json) {
    Info info;
    print('here');
    try {
      json =
          Map<String, Object?>.from(jsonDecode(json) as Map<Object, Object?>);
      info = Info(
        time: json['time'] != null ? int.parse(json['time'].toString()) : 0,
        budget:
            json['budget'] != null ? int.parse(json['budget'].toString()) : 0,
        filter: json['filter'] != null && (json['filter'] as List).isNotEmpty
            ? (json['filter'] as List<Object?>)
                .map((e) => e.toString())
                .toList()
            : [],
        mapName: json['map']?.toString(),
        accecibility:
            json['mpr'] != null ? bool.parse(json['mpr'].toString()) : null,
        map: json['mapData'] != null
            ? Map<String, Object>.from(json['mapData'] as Map<Object, Object>)
            : null,
      );
    } catch (e) {
      print('errro => $e');
      info = Info.empty();
    }
    print(info);
    return info;
  }

  factory Info.empty() => Info(
        filter: [],
      );

  @override
  String toString() => '$filter, $time + $budget + $map';

  Map<String, Object?> toJson(String token) => <String, Object?>{
        "budget": budget,
        "filter": filter,
        "nbPeople": 4,
        "time": time,
        "map": 'mapName',
        "mapData": map,
        'token': token,
        'mpr': accecibility
      };
}
