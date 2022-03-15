import 'package:splitbill/redux/app_state.dart';
import 'package:splitbill/redux/reducer/user_reducer.dart';
import 'package:test/test.dart';

void main() {
  group('User Reducer', () {
    test('login state should be logged in', () {
      var userState = UserState(
        phone: "+919876543210",
        userLoginState: UserLoginState.LOGGED_OUT,
        error: "",
      );

      userState = userReducer(
        userState,
        {
          'type': "VERIFY_OTP",
          "data": "+919876543210",
        },
      );
      expect(
        userState,
        equals(UserState(
          userLoginState: UserLoginState.LOGGEDIN,
          phone: "+919876543210",
        )),
      );
    });

    test('login state should be logged out', () {
      var userState = UserState(
        phone: "+919876543210",
        userLoginState: UserLoginState.LOGGED_OUT,
        error: "",
      );

      userState = userReducer(
        userState,
        {
          'type': "LOGOUT",
          "data": "+919876543210",
        },
      );
      expect(
        userState,
        equals(
          UserState(
            userLoginState: UserLoginState.LOGGED_OUT,
            phone: "",
            error: "",
          ),
        ),
      );
    });
  });
}
