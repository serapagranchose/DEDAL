import 'dart:async';

import 'package:dedal/constants/enum/authentification_enum.dart';
import 'package:dedal/core/datasources/authentification/login_datasource.dart';
import 'package:dedal/core/dtos/sign_in_dto.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/pages/authentification/authentification_event.dart';
import 'package:dedal/core/pages/authentification/authentification_state.dart';
import 'package:dedal/core/use_cases/get_credential.dart';
import 'package:dedal/core/use_cases/update_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {required GetCredential getCredential,
      required LoginDataSource loginDataSource,
      required UpdateUser updateUser})
      : _loginDataSource = loginDataSource,
        _getCredential = getCredential,
        _updateUser = updateUser,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    _authenticationStatusSubscription =
        _loginDataSource.status.listen((status) {
      add(AuthenticationStatusChanged(status));
    });
  }
  final GetCredential _getCredential;
  final LoginDataSource _loginDataSource;
  final UpdateUser _updateUser;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  Future<void> init() async {}

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();

    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      // case AuthenticationStatus.unauthenticated:
      //   return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.apiOffline:
        return emit(const AuthenticationState.apiOffline());
      case AuthenticationStatus.unauthenticated:
        final SigninDto? crendtial = await _getCredential
            .call(const NoParam())
            .fold((value) => value, (error) => null);
        if (crendtial.isNotNull) {
          final User? user = await _loginDataSource.signIn.call(
            crendtial?.email ?? '',
            crendtial?.password ?? '',
          );
          _updateUser(user);
          if (user.isNotNull) {
            emit(AuthenticationState.authenticated(user!));
            return;
          }
        }
        return emit(
          const AuthenticationState.unauthenticated(),
        );
      default:
        break;
    }
    return emit(const AuthenticationState.unknown());
  }
}
