import 'package:equatable/equatable.dart';

import 'package:dedal/constants/enum/authentification_enum.dart';
import 'package:dedal/core/models/user.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);
  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);
  const AuthenticationState.apiOffline()
      : this._(status: AuthenticationStatus.apiOffline);

  final AuthenticationStatus status;
  final User? user;

  @override
  List<Object?> get props => user != null ? [status, user!] : [status];
}
