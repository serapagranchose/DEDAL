import 'dart:convert';

import 'package:dedal/core/models/info.dart';
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
  });

  String? name;
  String? id;
  String? email;
  String? token;
  Info? info;
  LatLng? pos;

  factory User.fromJson(Map<String, Object?> json) {
    User user = User();
    try {
      user = User(
          id: json['id'].isNotNull ? json['id'].toString() : null,
          name: json['username'].isNotNull ? json['username'].toString() : null,
          email: json['email'].isNotNull ? json['email'].toString() : null,
          info: json['lastInfo'].isNotNull
              ? Info.toJson(jsonDecode(json['lastInfo'].toString())
                  as Map<String, Object?>)
              : null,
          token: json['token'].isNotNull ? json['token'].toString() : null);
    } catch (e) {
      print('error 2=> $e');
    }

    return user;
  }

  Map<String, Object?> toJson() => <String, Object?>{
        'Username': name,
        'Email': email,
        'lastInfo': info?.toJson()
      };

  @override
  String toString() => '$name, $email + $info, $id, $token';
}
