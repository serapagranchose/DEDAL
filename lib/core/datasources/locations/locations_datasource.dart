import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/models/user.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';

abstract class LocationsDataSource extends BaseDataSource {
  Future<List<Place>> getPlaceClose(User user);
  Future<List<Place>> getPlaceFilter(User user);
}
