import 'dart:convert';

import 'package:animated_login/animated_login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../response/res_user_insert.dart';
import '../response/res_user_list.dart';
import 'dialog_builders.dart';

class LoginFunctions {
  /// Collection of functions will be performed on login/signup.
  /// * e.g. [onLogin], [onSignup], [socialLogin], and [onForgotPassword]
  const LoginFunctions(this.context);

  final BuildContext context;

  /// Login action that will be performed on click to action button in login mode.
  Future<String?> onLogin(LoginData loginData) async {
    log.d('onLogin : ${loginData.email}');
    final dio = Dio();
    dio.options.headers['Content-Type'] =
        'application/x-www-form-urlencoded;charset=UTF-8';
    dio.options.responseType = ResponseType.plain;
    var url = "http://192.168.43.234:8001/user/list";
    log.d('onLogin : ${url}');
    var response = await dio.request(
      url,
      data: {
        'search': 'email',
        'searchValue': loginData.email,
      },
      options: Options(
        method: 'POST',
      ),
    );
    var jsonMap = json.decode(response.data);
    final resData = ResUserList.fromJson(jsonMap).data;
    if (resData?.header?.total == 0) {
      return '등록되지 않은 이메일입니다\n다시 확인해주세요';
    }
    var result = resData?.body?[0];
    log.d('where email sql 응답 : ${result?.name}');
    if (loginData.password != result?.password) {
      return '비밀번호가 맞지 않습니다\n다시 확인해주세요';
    }
    await Future.delayed(const Duration(seconds: 2));
    return 'OK ${result?.name}';
  }

  /// Sign up action that will be performed on click to action button in sign up mode.
  Future<String?> onSignup(SignUpData signupData) async {
    if (signupData.password != signupData.confirmPassword) {
      return '비밀번호가 같지 않습니다\n다시 확인해주세요';
    }
    final dio = Dio();
    dio.options.headers['Content-Type'] =
        'application/x-www-form-urlencoded;charset=UTF-8';
    dio.options.responseType = ResponseType.plain;
    var url = "http://192.168.43.234:8001/user/insert";
    var response = await dio.request(
      url,
      data: {
        'requestCode': 1002,
        'email': signupData.email,
        'password': signupData.password,
        'name': signupData.name,
        'age': 0,
        'mobile': '01000000000',
      },
      options: Options(
        method: 'POST',
      ),
    );
    var jsonMap = json.decode(response.data);
    final resData = ResUserInsert.fromJson(jsonMap).data;
    var result = resData?.body?.affectedRows;
    if (result == 0) {
      return '회원 등록 실패\n다시 확인해주세요';
    }
    await Future.delayed(const Duration(seconds: 2));
    return 'OK ${signupData.name}';
  }

  /// Social login callback example.
  Future<String?> socialLogin(String type) async {
    await Future.delayed(const Duration(seconds: 2));
    return null;
  }

  /// Action that will be performed on click to "Forgot Password?" text/CTA.
  /// Probably you will navigate user to a page to create a new password after the verification.
  Future<String?> onForgotPassword(String email) async {
    DialogBuilder(context).showLoadingDialog();
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed('/forgotPass');
    return null;
  }
}
