import 'package:dedal/core/models/user.dart';

class ChangeUsernameDto {
  ChangeUsernameDto({
    this.user,
    this.username,
  });

  User? user;
  String? username;
}
