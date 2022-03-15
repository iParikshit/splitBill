import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:splitbill/redux/action_dispatcher.dart';
import 'package:splitbill/redux/app_state.dart';

class LoginScreen extends StatelessWidget {
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);
    store.dispatch(autoLogin());
    phoneController.text = "9876543210";
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            StoreConnector<AppState, UserState>(
              converter: (store) {
                return store.state.userState;
              },
              builder: (context, userState) {
                print('rebuild login screen dart l-23');
                return Column(
                  children: [
                    TextField(
                      enabled:
                          userState.userLoginState == UserLoginState.LOGGED_OUT,
                      controller: phoneController,
                    ),
                    Visibility(
                      child: TextField(
                        decoration: InputDecoration(labelText: "OTP"),
                        controller: otpController,
                      ),
                      visible:
                          userState.userLoginState != UserLoginState.LOGGED_OUT,
                    ),
                    Visibility(
                      child:
                          Text(userState.error != null ? userState.error : ""),
                      visible: userState.userLoginState ==
                          UserLoginState.LOGIN_FAILED,
                    )
                  ],
                );
              },
            ),
            StoreConnector<AppState, UserState>(
              converter: (store) {
                // return AppStateWithAction(
                //     appState: store.state,
                //     dispatch: (input) {
                //       if (store.state.userState.userLoginState ==
                //           UserLoginState.LOGGED_OUT) {
                //         return store.dispatch(verifyPhoneNumber(phone: input));
                //       } else {
                //         return store.dispatch(verifyOtp(otp: input));
                //       }
                //     });
                return store.state.userState;
              },
              builder: (context, userState) {
                print('rebuild login screen dart l-62');
                return ElevatedButton(
                    onPressed: () {
                      if (userState.userLoginState ==
                          UserLoginState.LOGGED_OUT) {
                        store.dispatch(
                            verifyPhoneNumber(phone: phoneController.text));
                      } else {
                        store.dispatch(verifyOtp(otp: otpController.text));
                      }
                    },
                    child: Text("Continue"));
              },
            )
          ],
        ));
  }
}
