import 'package:dedal/core/models/info.dart';
import 'package:dedal/core/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  User({
    @HiveField(0) this.id,
    @HiveField(1) this.info,
    @HiveField(2) this.name,
    @HiveField(3) this.email,
    @HiveField(4) this.token,
    @HiveField(5) this.pos,
    @HiveField(6) this.places,
  });

  String? name;
  String? id;
  String? email;
  String? token;
  Info? info;
  LatLng? pos;
  List<Place>? places;

  factory User.fromJson(Map<String, Object?> json) {
    final user = User(
        id: json['id'].isNotNull ? json['id'].toString() : null,
        name: json['username'].isNotNull ? json['username'].toString() : null,
        email: json['email'].isNotNull ? json['email'].toString() : null,
        info: null,
        //  json['lastInfo'].isNotNull
        //     ? Info.toJson(
        //         Map<String, Object?>.from(
        //           json['lastInfo'] as Map<Object, Object?>,
        //         ),
        //       )
        //     : null,
        token: json['token'].isNotNull ? json['token'].toString() : 'token',
        pos: json['pos'].isNotNull
            ? LatLng(
                double.tryParse(Map<String, Object?>.from(
                            json['pos'] as Map<Object, Object?>)['x']
                        .toString()) ??
                    0,
                double.tryParse(Map<String, Object?>.from(
                            json['pos'] as Map<Object, Object?>)['y']
                        .toString()) ??
                    0,
              )
            : null);
    return user;
  }

  Map<String, Object?> toJson() => <String, Object?>{
        'username': name,
        'email': email,
        'lastInfo': info?.toJson(''),
        'token': token,
        'place': places,
        'id': id,
        'pos': {'x': pos?.latitude, 'y': pos?.longitude}
      };

  Map<String, Object?> posToJson() => <String, Object?>{
        'x': pos?.latitude,
        'y': pos?.longitude,
      };
  @override
  String toString() =>
      '$name, $email + $info, [${pos?.latitude} : ${pos?.longitude}]';
}
