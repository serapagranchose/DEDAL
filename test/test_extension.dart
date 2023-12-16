import 'package:dedal/core/extensions/string_extention.dart';
import 'package:flutter_test/flutter_test.dart';

void Function() extensionTest = () {
  test('capitalize', () {
    expect('test'.capitalize(), 'Test');
  });
};
