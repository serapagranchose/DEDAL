import 'package:dedal/constants/enum/authentification_enum.dart';
import 'package:dedal/core/models/user.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';

abstract class LoginDataSource extends BaseDataSource {
  Stream<AuthenticationStatus> get status;

  Future<User?> signIn(String email, String password);
  Future<bool> signUp(String email, String password);
  Future<bool> signUpCode(String email, String code);
  Future<bool> unsubscribe(String id, String email);
}
