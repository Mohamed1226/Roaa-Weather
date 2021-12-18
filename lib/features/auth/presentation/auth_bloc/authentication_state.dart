class AuthenticationState {}

class AuthenticationInitState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}
//class AuthenticationNoLoadingState extends AuthenticationState {}


class AuthenticationSucceedState extends AuthenticationState {
  final String uId;

  AuthenticationSucceedState(this.uId);
}
class PhoneNumberSubmitted extends AuthenticationState{}



class AuthenticationErrorState extends AuthenticationState {
  final String error;

  AuthenticationErrorState(this.error);
}

class AuthenticationVisibilityState extends AuthenticationState {}


class AuthenticationIsRememberState extends AuthenticationState {}
