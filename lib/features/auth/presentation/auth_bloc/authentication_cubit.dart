import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roaa_weather/features/auth/data/auth_repository/auth_repo.dart';

import 'authentication_state.dart';

class AuthCubit extends Cubit<AuthenticationState> {
  final AuthRepo authRepo;
  late String verificationId;

  AuthCubit(this.authRepo) : super(AuthenticationInitState());

  static AuthCubit get(context) => BlocProvider.of(context);
  bool isRemember = false;

  isRemembered(bool rem) {
    isRemember = rem;
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

  // void loginWithPhoneNumber() {
  //   emit(AuthenticationLoadingState());
  //   authRepo.loginWithPhoneNumber().then((value) {
  //     print("user login");
  //     emit(AuthenticationSucceedState(value.user!.uid));
  //   }).catchError((e) {
  //     print("user error ");
  //     emit(AuthenticationErrorState(e.toString()));
  //   });
  // }

  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(AuthenticationLoadingState());

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print('verificationCompleted');
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException e) {
    print('verificationFailed : ${e.toString()}');
    emit(AuthenticationErrorState(e.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    print('codeSent');
    this.verificationId = verificationId;
    emit(PhoneNumberSubmitted());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }

  Future<void> submitOTP(String otpCode) async {
    emit(AuthenticationLoadingState());

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);

    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(AuthenticationSucceedState(FirebaseAuth.instance.currentUser!.uid));
    } catch (e) {
      emit(AuthenticationErrorState(e.toString()));
    }
  }
}
