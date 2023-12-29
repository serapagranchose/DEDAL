import 'dart:async';

import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/use_cases/get_place.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class LocationPlaceDetailCubit extends Cubit<CrudState> {
  LocationPlaceDetailCubit({
    required GetPlace getPlace,
    required this.id,
  })  : _getPlace = getPlace,
        super(const CrudInitial());

  final GetPlace _getPlace;
  final String? id;

  FutureOr<void> load() async {
    print('heremmmzlz');
    emit(const CrudLoading());
    await _getPlace.call(id).fold((value) => emit(CrudLoaded<Place?>(value)),
        (error) => emit(const CrudError('Place not found')));
  }
}
