// This is an example unit test.
//
// A unit test tests a single function, method, or class. To learn more about
// writing unit tests, visit
// https://flutter.dev/docs/cookbook/testing/unit/introduction

import 'package:flutter_test/flutter_test.dart';

import 'test_extension.dart';
import 'test_filter.dart';
import 'test_filter_use_cases.dart';
import 'test_info.dart';
import 'test_init.dart';
import 'test_location_uses_cases.dart';
import 'test_login_use_cases.dart';
import 'test_place.dart';
import 'test_user.dart';

void main() async {
  await GetItInitializerTest.run();

  group('Test User Class', userTest);
  group('Test Filter Class', filterTest);
  group('Test Info Class', infoTest);
  group('Test Place Class', placeTest);
  group('Test extensention Class', extensionTest);
  group('Test login useCases', loginUseCasesTest);
  group('Test filters useCases', filterUseCasesTest);
  group('Test locations useCases', locationUseCasesTest);
}
