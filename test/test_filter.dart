import 'package:dedal/core/models/filter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

void Function() filterTest = () {
  final filter = Filter(
    name: 'test_name',
    id: 'test_id',
  );
  test('Filter from json', () {
    expect(Filter.fromJson({'id': 'test_id', 'name': 'test_name'}).name,
        'test_name');
  });

  test('Filter created', () {
    expect(filter.isNotNull, true);
  });
  test('Filter name', () {
    expect(filter.name, 'test_name');
  });
  test('Filter id', () {
    expect(filter.id, 'test_id');
  });
};
