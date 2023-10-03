import 'package:dedal/core/models/filter.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class Info {
  Info({
    this.filter,
    this.time,
    this.budget,
  });

  int? time;
  int? budget;
  List<String>? filter;

  factory Info.toJson(Map<String, Object?> json) {
    try {
      return Info(
          time: json['time'].isNotNull ? int.parse(json['time'].toString()) : 0,
          budget: json['budget'].isNotNull
              ? int.parse(json['budget'].toString())
              : 0,
          filter: json['filter'].isNotNull
              ? (json['filter'] as List<Object?>)
                  .map((e) => e.toString())
                  .toList()
              : []);
    } catch (e) {
      print('error => $e');
    }
    return Info();
  }

  @override
  String toString() => '$filter, $time + $budget';

  Map<String, Object?> toJson() =>
      <String, Object?>{'time': time, 'budget': budget, 'filter': filter};
}
