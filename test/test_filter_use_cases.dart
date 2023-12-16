import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/use_cases/get_filters.dart';
import 'package:dedal/core/use_cases/get_place.dart';
import 'package:dedal/core/use_cases/set_user_info.dart';
import 'package:dedal/core/use_cases/user_generat_route.dart';
import 'package:dedal/core/use_cases/user_get_map.dart';
import 'package:dedal/core/use_cases/user_get_path.dart';
import 'package:dedal/core/use_cases/user_get_place.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

import 'test_init.dart';

void Function() filterUseCasesTest = () {
  test('getFilters -- true', () async {
    final res = await GetFilters(filterDataSource: getIt())
        .call('test_token')
        .fold((value) => value, (error) => null);
    expect(res, []);
  });
  test('getFilters -- false', () async {
    final res = await GetFilters(filterDataSource: getIt())
        .call('')
        .fold((value) => value ?? false, (error) => null);
    expect(res, false);
  });
  test('getFilters -- null', () async {
    final res = await GetFilters(filterDataSource: getIt())
        .call(null)
        .fold((value) => value, (error) => null);
    expect(res, null);
  });
  test('getPlace -- true', () async {
    final res = await GetPlace(filterDataSource: getIt())
        .call('test_id')
        .fold((value) => value ?? false, (error) => null);
    expect(res.toString(), Place(name: 'test_name').toString());
  });
  test('getPlace -- false', () async {
    final res = await GetPlace(filterDataSource: getIt())
        .call('')
        .fold((value) => value ?? false, (error) => null);
    expect(res, false);
  });
  test('getPlace -- null', () async {
    final res = await GetPlace(filterDataSource: getIt())
        .call(null)
        .fold((value) => value ?? false, (error) => null);
    expect(res, null);
  });
  test('SetInfoUser -- true', () async {
    final res = await SetInfoUser(filterDataSource: getIt())
        .call(User(name: 'test_name'))
        .fold((value) => value, (error) => null);
    expect(res, true);
  });
  test('SetInfoUser -- false', () async {
    final res = await SetInfoUser(filterDataSource: getIt())
        .call(User(name: ''))
        .fold((value) => value, (error) => null);
    expect(res, false);
  });
  test('SetInfoUser -- null', () async {
    final res = await SetInfoUser(filterDataSource: getIt())
        .call(null)
        .fold((value) => value, (error) => null);
    expect(res, null);
  });
  test('UserGenerateRoute -- true', () async {
    final res = await UserGenerateRoute(filterDataSource: getIt())
        .call(User(name: 'test_name'))
        .fold((value) => value, (error) => null);
    expect(res, false);
  });
  test('UserGenerateRoute -- null', () async {
    final res = await UserGenerateRoute(filterDataSource: getIt())
        .call(null)
        .fold((value) => value, (error) => null);
    expect(res, null);
  });
  test('UserGetMap -- true', () async {
    final res = await UserGetMap(filterDataSource: getIt())
        .call(User(name: 'test_name'))
        .fold((value) => value, (error) => null);
    expect(res, {});
  });
  test('UserGetMap -- false', () async {
    final res = await UserGetMap(filterDataSource: getIt())
        .call(User(name: ''))
        .fold((value) => value ?? false, (error) => null);
    expect(res, false);
  });
  test('UserGetMap -- null', () async {
    final res = await UserGetMap(filterDataSource: getIt())
        .call(null)
        .fold((value) => value, (error) => null);
    expect(res, null);
  });
  test('UserGetPath -- true', () async {
    final res = await UserGetPath(filterDataSource: getIt())
        .call(User(name: 'test_name'))
        .fold((value) => value, (error) => null);
    expect(res, 'test_path');
  });
  test('UserGetPath -- false', () async {
    final res = await UserGetPath(filterDataSource: getIt())
        .call(User(name: ''))
        .fold((value) => value ?? false, (error) => null);
    expect(res, false);
  });
  test('UserGetPath -- null', () async {
    final res = await UserGetPath(filterDataSource: getIt())
        .call(null)
        .fold((value) => value, (error) => null);
    expect(res, null);
  });
  test('UserGetPlace -- true', () async {
    final res = await UserGetPlace(filterDataSource: getIt())
        .call(User(name: 'test_name'))
        .fold((value) => value, (error) => null);
    expect(res, []);
  });
  test('UserGetPlace -- false', () async {
    final res = await UserGetPlace(filterDataSource: getIt())
        .call(User(name: ''))
        .fold((value) => value ?? false, (error) => null);
    expect(res, false);
  });
  test('UserGetPlace -- null', () async {
    final res = await UserGetPlace(filterDataSource: getIt())
        .call(null)
        .fold((value) => value, (error) => null);
    expect(res, null);
  });
};
