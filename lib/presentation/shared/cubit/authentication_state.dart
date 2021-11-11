class AuthenticationState {}

class AuthenticationInitState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationSucceedState extends AuthenticationState {
  final String uId;

  AuthenticationSucceedState(this.uId);
}

class AuthenticationErrorState extends AuthenticationState {
  final String error;

  AuthenticationErrorState(this.error);
}

class AuthenticationVisibilityState extends AuthenticationState {}
