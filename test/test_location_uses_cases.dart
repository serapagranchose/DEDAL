import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/use_cases/locations_get_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

import 'test_init.dart';

void Function() locationUseCasesTest = () {
  test('LocationGetLists -- true', () async {
    final res = await LocationGetLists(
            filterDataSource: getIt(), locationsDataSource: getIt())
        .call(User(name: 'test_name'))
        .fold((value) => value, (error) => null);
    expect(res?.$1?.isNotNull, true);
  });
  test('LocationGetLists -- false', () async {
    final res = await LocationGetLists(
            filterDataSource: getIt(), locationsDataSource: getIt())
        .call(User(name: ''))
        .fold((value) => value, (error) => null);
    expect(res?.$1.isNull, true);
  });
  test('LocationGetLists -- null', () async {
    final res = await LocationGetLists(
            filterDataSource: getIt(), locationsDataSource: getIt())
        .call(null)
        .fold((value) => value, (error) => null);
    expect(res, null);
  });
};
