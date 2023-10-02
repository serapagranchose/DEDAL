import 'dart:async';

import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/use_cases/get_token.dart';
import 'package:dedal/core/use_cases/get_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class HomeCubit extends Cubit<CrudState> {
  HomeCubit({
    required GetToken getToken,
    required GetUser getUser,
  })  : _getToken = getToken,
        _getUser = getUser,
        super(const CrudInitial());

  final GetToken _getToken;
  final GetUser _getUser;

  FutureOr<void> load() async {
    emit(const CrudLoading());
    await _getUser.call(const NoParam()).fold((value) {
      if (value.isNotNull) {
        print('value ==+> $value');
        emit(CrudLoaded<User?>(value));
      } else {
        emit(const CrudError('User not found'));
      }
    }, (error) => emit(CrudError(error.toString())));
  }
}

//  if (_user?.pos == null) {
//       await Geolocator.requestPermission()
//           .then((value) {})
//           .onError((error, stackTrace) async {
//         await Geolocator.requestPermission();
//       });
//     }
//     emit(CrudLoaded<User?>(_user));
//   }
// }