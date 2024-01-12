import 'package:dedal/core/models/info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

void Function() infoTest = () {
  final info = Info(
    filter: [],
    time: 10,
    budget: 10,
    map: {},
    mapName: 'test_name',
  );
  test('Info created', () {
    expect(info.isNotNull, true);
  });
  test('Info to Json', () {
    expect(info.toJson('test_token'), {
      'budget': 10,
      'filter': [],
      'nbPeople': 4,
      'time': 10,
      'map': 'mapName',
      'mapData': {},
      'token': 'test_token'
    });
  });
  test('Info from Json', () {
    expect(
        Info.fromJson({
          'budget': 10,
          'filter': [],
          'nbPeople': 4,
          'time': 10,
          'map': 'mapName',
          'mapData': {},
          'token': 'test_token'
        }).map,
        'mapName');
  });
};
