import 'dart:async';

import 'package:dedal/core/models/filter.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/use_cases/get_filters.dart';
import 'package:dedal/core/use_cases/get_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class FiltersCubit extends Cubit<CrudState> {
  FiltersCubit({
    required GetUser getUser,
    required GetFilters getFilters,
  })  : _getUser = getUser,
        _getFilters = getFilters,
        super(const CrudInitial());

  final GetUser _getUser;
  final GetFilters _getFilters;
  User? user;

  FutureOr<void> load() async {
    emit(const CrudLoading());
    final getUserResult = await _getUser.call(const NoParam()).fold(
          (value) => value,
          (error) => null,
        );

    if (getUserResult.isNotNull) {
      user = getUserResult;
      _getFilters.call(getUserResult!.token).fold(
            (value) =>
                emit(CrudLoaded<(User, List<Filter>?)>((getUserResult, value))),
            (error) => emit(CrudError(error.message)),
          );
    }
  }

}
