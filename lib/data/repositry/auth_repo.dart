import 'package:firebase_auth/firebase_auth.dart';
import 'package:roaa_weather/data/auth_services/auth_web_service.dart';

import 'package:roaa_weather/presentation/widget/app_toast.dart';

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
