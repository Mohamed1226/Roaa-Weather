import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roaa_weather/data/repositry/auth_repo.dart';
import 'package:roaa_weather/presentation/shared/cubit/authentication_state.dart';

class AuthCubit extends Cubit<AuthenticationState> {
  final AuthRepo authRepo;


  AuthCubit(this.authRepo) : super(AuthenticationInitState());

  static AuthCubit get(context) => BlocProvider.of(context);
  bool isRemember=false;
  isRemembered(bool rem){
    isRemember=rem;
    emit(AuthenticationIsRememberState());
  }

  void userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone}) {

    emit(AuthenticationLoadingState());
    authRepo.register(password: password, email: email).then((value) {
      print("user register");
      emit(AuthenticationSucceedState(value.user!.uid));
    }).catchError((e) {
      print("user error  ");
      emit(AuthenticationErrorState(e.toString()));
    });
  }

  void logIn({required String email, required String password}) {
    emit(AuthenticationLoadingState());
    authRepo.login(email: email, password: password).then((value) {
      print("user login");
      emit(AuthenticationSucceedState(value.user!.uid));
    }).catchError((e) {
      print("user error ");
      emit(AuthenticationErrorState(e.toString()));
    });
  }

  bool _isVisible = true;

  bool get isVisible => _isVisible;

  void changeVisibility() {
    _isVisible = !_isVisible;
    emit(AuthenticationVisibilityState());
  }

  void loginWithGoogle() {
    emit(AuthenticationLoadingState());
    authRepo.loginWithGoogle().then((value) {
      print("user login");
      emit(AuthenticationSucceedState(value.user!.uid));
    }).catchError((e) {
      print("user error ");
      emit(AuthenticationErrorState(e.toString()));
    });
  }

  void loginWithFacebook() {
    emit(AuthenticationLoadingState());
    authRepo.loginWithFacebook().then((value) {
      print("user login");
      emit(AuthenticationSucceedState(value.user!.uid));
    }).catchError((e) {
      print("user error ");
      emit(AuthenticationErrorState(e.toString()));
    });
  }


}
