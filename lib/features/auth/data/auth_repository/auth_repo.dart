import 'package:roaa_weather/features/auth/data/auth_data_source/auth_web_service.dart';


class AuthRepo {
  final AuthWebService _authWebService;

  AuthRepo(this._authWebService);

  login({required String email, required String password}) {

      return _authWebService.login(email: email, password: password);

  }

  register({required String email, required String password}) {
    return _authWebService.register(email: email, password: password);
  }

  loginWithGoogle() {
    return _authWebService.signInWithGoogle();
  }

  loginWithFacebook() {
    return _authWebService.signInWithFacebook();
  }
}
