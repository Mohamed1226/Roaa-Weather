import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthWebService {

  late String id;
  Future<UserCredential> register({
    required String password,
    required String email,
  }) async {

    try {
      return FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    }catch(e){
           rethrow;
    }

  }

  Future<UserCredential> login(
      {required String email, required String password}) async {
try {
  return FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);
} catch(_){
  rethrow;
}
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return FirebaseAuth.instance.signInWithCredential(credential);
    }catch(e){
      rethrow;
    }
    //
  }

  Future<UserCredential> signInWithFacebook() async {
   // print("888");
try{
    final LoginResult loginResult = await FacebookAuth.instance.login();
    var accessToken = loginResult.accessToken;
    print("llll");
   print(accessToken);
    print("999");

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);}
    catch(e){
  throw(e);
    }
  }


  // Future<void> signInWithPhoneNumber(String phoneNumber) async {
  //   // print("888");
  //   try{
  //     await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: "+2$phoneNumber",
  //       verificationCompleted: (PhoneAuthCredential credential) async{
  //         print("verificationCompleted");
  //        // await signIn(credential);
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         print("verificationFailed $e");
  //
  //         throw(e);
  //       },
  //       codeSent: (String verificationId, int? resendToken) {
  //         id=verificationId;
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {},
  //     );
  //
  //   }
  //   catch(e){
  //     throw(e);
  //   }
  // }
}
