import 'package:splitbill/redux/app_state.dart';

UserState userReducer(UserState state, action) {
  if (action['type'] == "VERIFY_PHONE") {
    return UserState(
      phone: action['data'],
      userLoginState: UserLoginState.LOGGING_IN,
    );
  }
  if (action['type'] == "VERIFY_OTP") {
    return UserState(
      phone: state.phone,
      userLoginState: UserLoginState.LOGGEDIN,
    );
  }
  if (action['type'] == "INVALID_OTP") {
    return UserState(
        error: "Invalid Otp",
        userLoginState: UserLoginState.LOGIN_FAILED,
        phone: state.phone);
  }
  if (action['type'] == 'AUTO_LOGIN') {
    return UserState(
        error: "",
        userLoginState: UserLoginState.LOGGEDIN,
        phone: action['data']);
  }
  if (action['type'] == 'LOGOUT') {
    return UserState(
        error: "", userLoginState: UserLoginState.LOGGED_OUT, phone: "");
  }
  return UserState(userLoginState: state.userLoginState, phone: state.phone);
}
