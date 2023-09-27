import 'package:dedal/core/models/info.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class User {
  User({
    this.id,
    this.info,
    this.name,
    this.email,
    this.token,
  });

  String? name;
  String? id;
  String? email;
  String? token;
  Info? info;

  factory User.fromJson(Map<String, Object?> json) {
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
