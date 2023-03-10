import 'package:animated_login/animated_login.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nuflix/data/app_data.dart';

import '../util/login_functions.dart';
import '../util/util.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// Example selected language, default is English.
  LanguageOption language = _languageOptions[0];

  /// Current auth mode, default is [AuthMode.login].
  AuthMode currentMode = AuthMode.login;

  CancelableOperation? _operation;

  @override
  Widget build(BuildContext context) {
    return AnimatedLogin(
      onLogin: (LoginData data) async =>
          _authOperation(LoginFunctions(context).onLogin(data)),
      onSignup: (SignUpData data) async =>
          _authOperation(LoginFunctions(context).onSignup(data)),
      onForgotPassword: _onForgotPassword,
      logo: Image.asset('assets/images/login/logo.gif'),
      // backgroundImage: 'images/login/background_image.jpg',
      signUpMode: SignUpModes.both,
      // socialLogins: _socialLogins(context),
      loginDesktopTheme: _desktopTheme,
      loginMobileTheme: _mobileTheme,
      loginTexts: _loginTexts,
      emailValidator: ValidatorModel(
          validatorCallback: (String? email) => '이메일 형식에 맞지 않아요! $email'),
      changeLanguageCallback: (LanguageOption? _language) {
        if (_language != null) {
          // DialogBuilder(context).showResultDialog(
          //     'Successfully changed the language to: ${_language.value}.');
          if (mounted) setState(() => language = _language);
        }
      },
      changeLangDefaultOnPressed: () async => _operation?.cancel(),
      languageOptions: _languageOptions,
      selectedLanguage: language,
      initialMode: currentMode,
      onAuthModeChange: (AuthMode newMode) async {
        currentMode = newMode;
        await _operation?.cancel();
      },
    );
  }

  Future<String?> _authOperation(Future<String?> func) async {
    await _operation?.cancel();
    _operation = CancelableOperation.fromFuture(func);
    final String? res = await _operation?.valueOrCancellation();
    if (_operation?.isCompleted == true) {
      if (!res!.startsWith('OK')) {
        Util.showTextDialog(title: res);
      } else {
        final userName = res.split('|')[1];
        await Get.find<AppData>().prefs.setString('userName', userName);
        Fluttertoast.showToast(
          msg: '[$userName]님 좋은 하루 되세요!',
          toastLength: Toast.LENGTH_LONG,
        );
        Get.toNamed('/home');
      }
    }
    return res;
  }

  Future<String?> _onForgotPassword(String email) async {
    await _operation?.cancel();
    return await LoginFunctions(context).onForgotPassword(email);
  }

  static List<LanguageOption> get _languageOptions => const <LanguageOption>[
        LanguageOption(
          value: '한국어',
          code: 'KR',
          iconPath: 'assets/images/login/kr.png',
        ),
        LanguageOption(
          value: 'English',
          code: 'EN',
          iconPath: 'assets/images/login/en.png',
        ),
      ];

  /// You can adjust the colors, text styles, button styles, borders
  /// according to your design preferences for *DESKTOP* view.
  /// You can also set some additional display options such as [showLabelTexts].
  LoginViewTheme get _desktopTheme => _mobileTheme.copyWith(
        // To set the color of button text, use foreground color.
        actionButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
        dialogTheme: const AnimatedDialogTheme(
          languageDialogTheme: LanguageDialogTheme(
              optionMargin: EdgeInsets.symmetric(horizontal: 80)),
        ),
        loadingSocialButtonColor: Colors.blue,
        loadingButtonColor: Colors.white,
        privacyPolicyStyle: const TextStyle(color: Colors.black87),
        privacyPolicyLinkStyle: const TextStyle(
            color: Colors.blue, decoration: TextDecoration.underline),
      );

  /// You can adjust the colors, text styles, button styles, borders
  /// according to your design preferences for *MOBILE* view.
  /// You can also set some additional display options such as [showLabelTexts].
  LoginViewTheme get _mobileTheme => LoginViewTheme(
        // showLabelTexts: false,
        backgroundColor: Colors.blue,
        // const Color(0xFF6666FF),
        formFieldBackgroundColor: Colors.white,
        formWidthRatio: 60,
        actionButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.blue),
        ),
        animatedComponentOrder: const <AnimatedComponent>[
          AnimatedComponent(
            component: LoginComponents.logo,
            animationType: AnimationType.right,
          ),
          AnimatedComponent(component: LoginComponents.title),
          AnimatedComponent(component: LoginComponents.description),
          AnimatedComponent(component: LoginComponents.formTitle),
          AnimatedComponent(component: LoginComponents.socialLogins),
          AnimatedComponent(component: LoginComponents.useEmail),
          AnimatedComponent(component: LoginComponents.form),
          AnimatedComponent(component: LoginComponents.notHaveAnAccount),
          AnimatedComponent(component: LoginComponents.forgotPassword),
          AnimatedComponent(component: LoginComponents.policyCheckbox),
          AnimatedComponent(component: LoginComponents.changeActionButton),
          AnimatedComponent(component: LoginComponents.actionButton),
        ],
        privacyPolicyStyle: const TextStyle(color: Colors.white70),
        privacyPolicyLinkStyle: const TextStyle(
            color: Colors.white, decoration: TextDecoration.underline),
      );

  LoginTexts get _loginTexts => LoginTexts(
        loginFormTitle: loginFormTitle,
        loginEmailHint: loginEmailHint,
        loginPasswordHint: loginPasswordHint,
        signUpFormTitle: signUpFormTitle,
        signupEmailHint: signupEmailHint,
        signupPasswordHint: signupPasswordHint,
        confirmPasswordHint: confirmPasswordHint,
        nameHint: nameHint,
        login: login,
        signUp: signUp,
        welcome: welcome,
        welcomeDescription: welcomeDescription,
        welcomeBack: welcomeBack,
        welcomeBackDescription: welcomeBackDescription,
        notHaveAnAccount: notHaveAnAccount,
        alreadyHaveAnAccount: alreadyHaveAnAccount,
        forgotPassword: forgotPassword,
        agreementText: agreementText,
        privacyPolicyText: privacyPolicyText,
        termsConditionsText: termsConditionsText,
        privacyPolicyLink:
            'https://www.dailysecu.com/news/photo/202006/109373_128403_3942.jpg',
        termsConditionsLink:
            'http://amina.co.kr/data/editor/1705/422f5b81df7d918598820f93dd71ee62_1494364270_5891.png',
      );

  /// You can adjust the texts in the screen according to the current language
  /// With the help of [LoginTexts], you can create a multilanguage scren.
  String get nameHint => language.code == 'KR' ? '이름' : 'Username';

  String get login => language.code == 'KR' ? '로그인' : 'Login';

  String get signUp => language.code == 'KR' ? '회원가입' : 'Sign Up';

  String get welcome => language.code == 'KR' ? '환영합니다!' : 'Welcome!';

  String get welcomeDescription => language.code == 'KR'
      ? '잘 찾아오셨어요. 회원가입은 간단합니다!'
      : 'You are where you find the best you are looking for!';

  String get welcomeBack => language.code == 'KR' ? '안녕하세요!' : 'Welcome Back!';

  String get welcomeBackDescription => language.code == 'KR'
      ? '기다리고 있었어요. 좋은 시간 보내세요!'
      : 'Welcome back to the best We are always here, waiting for you!';

  String get notHaveAnAccount =>
      language.code == 'KR' ? '아직 계정이 없으신가요?' : 'Not have an account?';

  String get alreadyHaveAnAccount =>
      language.code == 'KR' ? '이미 계정이 있으신가요?' : 'Already have an account?';

  String get forgotPassword =>
      language.code == 'KR' ? '비밀번호를 잊었나요?' : 'Forgot Password?';

  String get loginFormTitle =>
      language.code == 'KR' ? '계정 로그인' : 'Login to Account';

  String get loginEmailHint => language.code == 'KR' ? '이메일' : 'Email';

  String get loginPasswordHint => language.code == 'KR' ? '비밀번호' : 'Password';

  String get signUpFormTitle =>
      language.code == 'KR' ? '계정 만들기' : 'Create an Account';

  String get signupEmailHint => language.code == 'KR' ? '이메일' : 'Email';

  String get signupPasswordHint => language.code == 'KR' ? '비밀번호' : 'Password';

  String get confirmPasswordHint =>
      language.code == 'KR' ? '비밀번호 확인' : 'Confirm Password';

  String get agreementText =>
      language.code == 'KR' ? '이 내용에 동의합니다. ' : 'I agree to the ';

  String get privacyPolicyText =>
      language.code == 'KR' ? '개인정보 보호정책' : 'Privacy Policy';

  String get termsConditionsText =>
      language.code == 'KR' ? '이용약관' : 'Terms & Conditions';

  /// Social login options, you should provide callback function and icon path.
  /// Icon paths should be the full path in the assets
  /// Don't forget to also add the icon folder to the "pubspec.yaml" file.
  List<SocialLogin> _socialLogins(BuildContext context) => <SocialLogin>[
        SocialLogin(
            callback: () async => _socialCallback('Google'),
            iconPath: 'assets/images/login/google.png'),
        SocialLogin(
            callback: () async => _socialCallback('Facebook'),
            iconPath: 'assets/images/login/facebook.png'),
        SocialLogin(
            callback: () async => _socialCallback('LinkedIn'),
            iconPath: 'assets/images/login/linkedin.png'),
      ];

  Future<String?> _socialCallback(String type) async {
    await _operation?.cancel();
    _operation = CancelableOperation.fromFuture(
        LoginFunctions(context).socialLogin(type));
    final String? res = await _operation?.valueOrCancellation();
    if (_operation?.isCompleted == true && res == null) {
      // Util.showTextDialog(title: 'Successfully logged in with $type.');
      Get.toNamed('/home');
    }
    return res;
  }
}
