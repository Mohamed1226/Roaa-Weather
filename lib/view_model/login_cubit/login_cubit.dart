import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roaa_weather/data/models/login_model.dart';

import 'login_state.dart';

class CubitLogIn extends Cubit<LoginState> {
  CubitLogIn() : super(SocialLoginInitState());

  static CubitLogIn get(context) => BlocProvider.of(context);

  LoginModel _model = LoginModel();
  LoginModel get model => _model;
  void userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    print("hello");
    emit(SocialLoginLoadingState());
    _model.userRegister(password: password, email: email).then((value) {
      print("user register");
      emit(SocialLoginSucceedState(value.user!.uid));
    }).catchError((e) {
      print("user error  ");
      emit(SocialLoginErrorState(e.toString()));
    });
  }

  void logIn({required String email, required String password}) {
    emit(SocialLoginLoadingState());
    _model.logIn(email: email, password: password).then((value) {
      print("user login");
      emit(SocialLoginSucceedState(value.user!.uid));
    }).catchError((e) {
      print("user error ");
      emit(SocialLoginErrorState(e.toString()));
    });
  }

  bool _isVisible = true;
  bool get isVisible =>_isVisible;
  void changeVisibility() {
    _isVisible = !_isVisible;
    emit(SocialChangeVisibiltyState());
  }
}
