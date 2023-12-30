import 'dart:async';

import 'package:dedal/core/models/filter.dart';
import 'package:dedal/core/use_cases/get_filters.dart';
import 'package:dedal/core/use_cases/get_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class HomePlaceFilterCubit extends Cubit<CrudState> {
  HomePlaceFilterCubit({
    required GetFilters getFilters,
    required GetUser getUser,
  })  : _getFilters = getFilters,
        _getUser = getUser,
        super(const CrudInitial());

  final GetFilters _getFilters;
  final GetUser _getUser;

  FutureOr<void> load() async {
    final getUserResult = await _getUser.call(null).fold(
          (value) => value,
          (error) => null,
        );
    if (getUserResult.isNotNull) {
      _getFilters.call(getUserResult!.token).fold(
            (value) => emit(CrudLoaded<List<Filter>?>(value)),
            (error) => emit(CrudError(error.message)),
          );
    }
  }
}
