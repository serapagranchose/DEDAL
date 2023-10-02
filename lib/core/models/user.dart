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
    print('user => $json');
    var user = User(
        id: json['id'].isNotNull ? json['id'].toString() : null,
        name: json['Username'].isNotNull ? json['Username'].toString() : null,
        email: json['Email'].isNotNull ? json['Email'].toString() : null,
        info: json['lastInfo'].isNotNull
            ? Info.toJson(json['lastInfo'] as Map<String, Object?>)
            : null,
        token: json['token'].isNotNull ? json['token'].toString() : null);
    return user;
  }

  Map<String, Object?> toJson() => <String, Object?>{
        'Username': name,
        'Email': email,
        'lastInfo': info?.toJson()
      };

  @override
  String toString() => '$name, $email + $info, $id';
}
