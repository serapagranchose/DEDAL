import 'dart:async';

import 'package:dedal/constants/enum/authentification_enum.dart';
import 'package:dedal/core/datasources/authentification/login_datasource.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/pages/authentification/authentification_event.dart';
import 'package:dedal/core/pages/authentification/authentification_state.dart';
import 'package:dedal/core/use_cases/get_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required GetUser getUser,
    required LoginDataSource loginDataSource,
  })  : _loginDataSource = loginDataSource,
        _getUser = getUser,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    _authenticationStatusSubscription =
        _loginDataSource.status.listen((status) {
      add(AuthenticationStatusChanged(status));
    });
  }
  final GetUser _getUser;
  final LoginDataSource _loginDataSource;
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
        final User? user = await _getUser
            .call(const NoParam())
            .fold((value) => value, (error) => null);
        return emit(
          user != null
              ? AuthenticationState.authenticated(user)
              : const AuthenticationState.unauthenticated(),
        );
      case AuthenticationStatus.unknown:
        break;
      case AuthenticationStatus.loggingIn:
        break;

      case AuthenticationStatus.authenticated:
        final User? user = await _getUser
            .call(const NoParam())
            .fold((value) => value, (error) => null);
        return emit(
          user != null
              ? AuthenticationState.authenticated(user)
              : const AuthenticationState.unauthenticated(),
        );
    }
    return emit(const AuthenticationState.unknown());
  }
}
