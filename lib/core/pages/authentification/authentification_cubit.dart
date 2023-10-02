import 'dart:async';

import 'package:dedal/constants/enum/authentification_enum.dart';
import 'package:dedal/core/datasources/authentification/login_datasource.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/pages/authentification/authentification_event.dart';
import 'package:dedal/core/pages/authentification/authentification_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required LoginDataSource loginDataSource,
  })  : _loginDataSource = loginDataSource,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    _authenticationStatusSubscription =
        _loginDataSource.status.listen((status) {
      add(AuthenticationStatusChanged(status));
    });
  }
  late Box<User> _user;
  final LoginDataSource _loginDataSource;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  // UserDatasource get userDatasource => _userDatasource;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _user = await Hive.openBox<User>('user');
  }

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
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.apiOffline:
        return emit(const AuthenticationState.apiOffline());
      case AuthenticationStatus.authenticated:
        final User? user = await _tryGetUser();

        return emit(
          user != null
              ? AuthenticationState.authenticated(user)
              : const AuthenticationState.unauthenticated(),
        );
      case AuthenticationStatus.unknown:
        break;
      case AuthenticationStatus.loggingIn:
        break;
    }
    return emit(const AuthenticationState.unknown());
  }

  Future<User?> _tryGetUser() async {
    try {
      // final user = await _userDatasource.getUser(force: true);
      // return user.value;
    } catch (e, __) {
      if (kDebugMode) {}
      return null;
    }
    return null;
  }

  void setUser(User value) => _user.put('user', value);

  User? getUser() => _user.get('user');
}
