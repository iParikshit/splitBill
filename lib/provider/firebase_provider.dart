import 'package:firebase_auth/firebase_auth.dart';

class FirebaseProvider {
  //todo create a singleton class

  static final FirebaseProvider _firebaseProvider =
      FirebaseProvider._internal();

  factory FirebaseProvider() {
    return _firebaseProvider;
  }

  FirebaseProvider._internal();

  var _authVerificationId;

  verifyPhoneNumber({String phone, Function onCodeSent}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    print('a');
    print(auth.currentUser);
    print('b');
    await auth.verifyPhoneNumber(
      phoneNumber: '+91${phone}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        //todo dispatch action, login done with out otp
        print('completed\n\n\n\n\n\n');
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('fail');
        print(e.message);
      },
      codeSent: (String verificationId, int resendToken) {
        _authVerificationId = verificationId;
        print('code sent');
        onCodeSent();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  verifyOtp({String otp, Function onFail, Function onSuccess}) async {
    print('provider otp');
    print(otp);
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: _authVerificationId, smsCode: otp);
      await auth.signInWithCredential(phoneAuthCredential);
      onSuccess();
    } catch (e) {
      if (e is FirebaseAuthException) {
        onFail();
      }
    }
  }

  getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
