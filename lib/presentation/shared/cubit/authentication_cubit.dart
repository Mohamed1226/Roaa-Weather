import 'package:bloc/bloc.dart';
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



  // Future<dynamic> signInWithGoogle() async {
  //   emit(SocialLoginLoadingState());
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   final GoogleSignInAuthentication? googleAuth =
  //   await googleUser?.authentication;
  //
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //   FirebaseAuth.instance.signInWithCredential(credential).then((user) {
  //     createUserInFireStore(
  //         name: user.user!.uid,
  //         email: user.user!.email,
  //         phone: user.user!.phoneNumber,
  //         uId: user.user!.uid);
  //
  //     emit(SocialLoginSucceedState(googleUser!.id.toString()));
  //     return user;
  //   }).catchError((onError) {
  //     emit(SocialLoginErrorState(onError.toString()));
  //   });
  //   // Once signed in, return the UserCredential
  // }
  //
  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential =
  //   FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //
  //   FirebaseAuth.instance
  //       .signInWithCredential(facebookAuthCredential)
  //       .then((user) {
  //     createUserInFireStore(
  //         name: user.user!.uid,
  //         email: user.user!.email,
  //         phone: user.user!.phoneNumber,
  //         uId: user.user!.uid);
  //
  //     emit(SocialLoginSucceedState(facebookAuthCredential.idToken.toString()));
  //   }).catchError((onError) {
  //     emit(SocialLoginErrorState(onError.toString()));
  //   });
  //
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }
}
