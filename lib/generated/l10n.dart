// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Splash Screen From Flutter`
  String get Splash_Screen_From_Flutter {
    return Intl.message(
      'Splash Screen From Flutter',
      name: 'Splash_Screen_From_Flutter',
      desc: '',
      args: [],
    );
  }

  /// `Roaa Weather App`
  String get Roaa_Weather_App {
    return Intl.message(
      'Roaa Weather App',
      name: 'Roaa_Weather_App',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get login {
    return Intl.message(
      'Sign In',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `enter your email`
  String get enter_your_email {
    return Intl.message(
      'enter your email',
      name: 'enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `email can not be empty`
  String get email_can_not_be_empty {
    return Intl.message(
      'email can not be empty',
      name: 'email_can_not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `enter your Name`
  String get enter_your_name {
    return Intl.message(
      'enter your Name',
      name: 'enter_your_name',
      desc: '',
      args: [],
    );
  }

  /// `Name can not be empty`
  String get name_can_not_be_empty {
    return Intl.message(
      'Name can not be empty',
      name: 'name_can_not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `phone`
  String get phone {
    return Intl.message(
      'phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `enter yur phone`
  String get enter_your_phone {
    return Intl.message(
      'enter yur phone',
      name: 'enter_your_phone',
      desc: '',
      args: [],
    );
  }

  /// `phone number required`
  String get phone_can_not_be_empty {
    return Intl.message(
      'phone number required',
      name: 'phone_can_not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Not Correct Email`
  String get Not_Correct_Email {
    return Intl.message(
      'Not Correct Email',
      name: 'Not_Correct_Email',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password {
    return Intl.message(
      'password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Password`
  String get Enter_Your_Password {
    return Intl.message(
      'Enter Your Password',
      name: 'Enter_Your_Password',
      desc: '',
      args: [],
    );
  }

  /// `Password can not be empty`
  String get Password_can_not_be_empty {
    return Intl.message(
      'Password can not be empty',
      name: 'Password_can_not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Not Strong Password`
  String get Not_Strong_Password {
    return Intl.message(
      'Not Strong Password',
      name: 'Not_Strong_Password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get Confirm_Password {
    return Intl.message(
      'Confirm Password',
      name: 'Confirm_Password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Your Password`
  String get Confirm_Your_Password {
    return Intl.message(
      'Confirm Your Password',
      name: 'Confirm_Your_Password',
      desc: '',
      args: [],
    );
  }

  /// `passwords not matches`
  String get passwords_not_matches {
    return Intl.message(
      'passwords not matches',
      name: 'passwords_not_matches',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password`
  String get Forget_Password {
    return Intl.message(
      'Forget Password',
      name: 'Forget_Password',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get Remember_Me {
    return Intl.message(
      'Remember Me',
      name: 'Remember_Me',
      desc: '',
      args: [],
    );
  }

  /// `LOGIN`
  String get LOGIN {
    return Intl.message(
      'LOGIN',
      name: 'LOGIN',
      desc: '',
      args: [],
    );
  }

  /// `-OR-`
  String get OR {
    return Intl.message(
      '-OR-',
      name: 'OR',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with`
  String get Sign_in_with {
    return Intl.message(
      'Sign in with',
      name: 'Sign_in_with',
      desc: '',
      args: [],
    );
  }

  /// `Dont Have an email?`
  String get Dont_have_account {
    return Intl.message(
      'Dont Have an email?',
      name: 'Dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `have an account?`
  String get have_account {
    return Intl.message(
      'have an account?',
      name: 'have_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get Sign_up {
    return Intl.message(
      'Sign up',
      name: 'Sign_up',
      desc: '',
      args: [],
    );
  }

  /// `REGISTER`
  String get REGISTER {
    return Intl.message(
      'REGISTER',
      name: 'REGISTER',
      desc: '',
      args: [],
    );
  }

  /// `Open GPS`
  String get Open_GPS {
    return Intl.message(
      'Open GPS',
      name: 'Open_GPS',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get Sign_Out {
    return Intl.message(
      'Sign Out',
      name: 'Sign_Out',
      desc: '',
      args: [],
    );
  }

  /// `please check internet connection to refresh your data`
  String get check_internet {
    return Intl.message(
      'please check internet connection to refresh your data',
      name: 'check_internet',
      desc: '',
      args: [],
    );
  }

  /// `Flutter Weather`
  String get Flutter_Weather {
    return Intl.message(
      'Flutter Weather',
      name: 'Flutter_Weather',
      desc: '',
      args: [],
    );
  }

  /// `Search For Your Country Weather`
  String get search_country {
    return Intl.message(
      'Search For Your Country Weather',
      name: 'search_country',
      desc: '',
      args: [],
    );
  }

  /// `Search can not be empty`
  String get Search_can_not_be_empty {
    return Intl.message(
      'Search can not be empty',
      name: 'Search_can_not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Wind`
  String get Wind {
    return Intl.message(
      'Wind',
      name: 'Wind',
      desc: '',
      args: [],
    );
  }

  /// `Pressure`
  String get Pressure {
    return Intl.message(
      'Pressure',
      name: 'Pressure',
      desc: '',
      args: [],
    );
  }

  /// `FeelsLike`
  String get FeelsLike {
    return Intl.message(
      'FeelsLike',
      name: 'FeelsLike',
      desc: '',
      args: [],
    );
  }

  /// `Humidity`
  String get Humidity {
    return Intl.message(
      'Humidity',
      name: 'Humidity',
      desc: '',
      args: [],
    );
  }

  /// `°C`
  String get C {
    return Intl.message(
      '°C',
      name: 'C',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Please Input Your Phone Number`
  String get Please_Input_Your_Phone_Number {
    return Intl.message(
      'Please Input Your Phone Number',
      name: 'Please_Input_Your_Phone_Number',
      desc: '',
      args: [],
    );
  }

  /// `please verify your phone number with 6 digit code numbers sent to your phone`
  String get verify_phone {
    return Intl.message(
      'please verify your phone number with 6 digit code numbers sent to your phone',
      name: 'verify_phone',
      desc: '',
      args: [],
    );
  }

  /// `verify`
  String get verify {
    return Intl.message(
      'verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar', countryCode: 'EG'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
