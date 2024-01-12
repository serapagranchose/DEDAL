import 'package:dedal/core/dtos/change_username_dto.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:dedal/core/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void Function() extensionTest = () {
  test('capitalize', () {
    expect('test'.capitalize(), 'Test');
  });

  test('DTO', () {
    expect(ChangeUsernameDto(user: User(), username: 'test_username').username,
        'test_userName');
  });
};
