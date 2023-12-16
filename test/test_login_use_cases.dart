import 'package:dedal/core/dtos/sign_in_dto.dart';
import 'package:dedal/core/dtos/sign_up_dto.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/use_cases/sign_in.dart';
import 'package:dedal/core/use_cases/sign_up_code.dart';
import 'package:dedal/core/use_cases/user_unsubscribe.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

import 'test_init.dart';

void Function() loginUseCasesTest = () {
  test('User_unsubscribe -- true', () async {
    final res = await UserUnsubscribe(loginDataSource: getIt())
        .call(User(email: 'test_email', id: 'test_id'))
        .fold((value) => value, (error) => null);

    expect(res, true);
  });
  test('User_unsubscribe -- false', () async {
    final res = await UserUnsubscribe(loginDataSource: getIt())
        .call(User(email: '', id: ''))
        .fold((value) => value, (error) => null);

    expect(res, false);
  });
  test('User_signin -- true', () async {
    final res = await SignIn(loginDataSource: getIt())
        .call(SigninDto(email: 'test_email', password: 'test_password'))
        .fold((value) => value, (error) => null);

    expect(res.toString(), User().toString());
  });
  test('User_signin -- null', () async {
    final res = await SignIn(loginDataSource: getIt())
        .call(SigninDto(email: '', password: ''))
        .fold((value) => value, (error) => null);

    expect(res, null);
  });
  test('User_signupCode -- true', () async {
    final res = await SignUpCode(loginDataSource: getIt())
        .call(SignUpDto(
            email: 'test_email', password: 'test_password', code: 'test_code'))
        .fold((value) => value, (error) => null);

    expect(res, true);
  });
  test('User_signupCode -- false', () async {
    final res = await SignUpCode(loginDataSource: getIt())
        .call(SignUpDto(email: '', password: '', code: ''))
        .fold((value) => value, (error) => null);

    expect(res, false);
  });
  test('User_signup -- true', () async {
    final res = await SignUpCode(loginDataSource: getIt())
        .call(SignUpDto(
            email: 'test_email', password: 'test_password', code: 'test_code'))
        .fold((value) => value, (error) => null);

    expect(res, true);
  });
  test('User_signup -- false', () async {
    final res = await SignUpCode(loginDataSource: getIt())
        .call(SignUpDto(email: '', password: '', code: ''))
        .fold((value) => value, (error) => null);

    expect(res, false);
  });
};
