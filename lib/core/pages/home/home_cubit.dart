import 'dart:async';

import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/pages/authentification/authentification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';

class HomeCubit extends Cubit<CrudState> {
  HomeCubit() : super(const CrudInitial());

// ignore: prefer_typing_uninitialized_variables
  late User? _user;
  FutureOr<void> load(BuildContext context) async {
    emit(const CrudLoading());
    _user = context.read<AuthenticationBloc>().getUser();

    _user?.pos = await Geolocator.getCurrentPosition()
        .then((value) => LatLng(value.latitude, value.longitude));
    if (_user?.pos == null)
      await Geolocator.requestPermission()
          .then((value) {})
          .onError((error, stackTrace) async {
        await Geolocator.requestPermission();
      });
    emit(CrudLoaded<User?>(_user));
  }
}
