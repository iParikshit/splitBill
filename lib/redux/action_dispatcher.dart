import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:splitbill/models/bill.dart';
import 'package:splitbill/provider/api_provider.dart';
import 'package:splitbill/provider/contact_provider.dart';
import 'package:splitbill/provider/firebase_provider.dart';
import 'package:splitbill/redux/app_state.dart';

ThunkAction<AppState> autoLogin() {
  return (Store<AppState> store) async {
    var user = FirebaseProvider().getCurrentUser();
    if (FirebaseProvider().getCurrentUser() != null) {
      var fcm = await FirebaseMessaging.instance.getToken();
      await ApiProvider().saveFCMToken(phone: user.phoneNumber, token: fcm);
      return store.dispatch({"type": "AUTO_LOGIN", "data": user.phoneNumber});
    }
    return store.dispatch({});
  };
}

ThunkAction<AppState> verifyPhoneNumber({String phone}) {
  return (Store<AppState> store) async {
    await FirebaseProvider().verifyPhoneNumber(
        phone: phone,
        onCodeSent: () {
          store.dispatch({"type": "VERIFY_PHONE", "data": phone});
        });
  };
}

ThunkAction<AppState> verifyOtp({String otp}) {
  return (Store<AppState> store) async {
    await FirebaseProvider().verifyOtp(
        otp: otp,
        onFail: () {
          store.dispatch({"type": "INVALID_OTP"});
        },
        onSuccess: () async {
          var fcm = await FirebaseMessaging.instance.getToken();
          await ApiProvider()
              .saveFCMToken(phone: store.state.userState.phone, token: fcm);
          store.dispatch({"type": "VERIFY_OTP"});
        });
  };
}

ThunkAction<AppState> readContacts() {
  return (Store<AppState> store) async {
    store.dispatch({'type': "READING_CONTACTS"});
    await ContactProvider().readContacts(onPermissionNotGranted: () {
      store.dispatch({"type": "READ_CONTACTS_NO_PERMISSION"});
    }, onPermissionGranted: (contacts) {
      store.dispatch({"type": "READ_CONTACTS", "data": contacts});
    });
  };
}

selectContact(Contact contact) {
  return {"type": "SELECT_CONTACT", "data": contact};
}

ThunkAction<AppState> getBill() {
  return (Store<AppState> store) async {
    Bill bill = await ApiProvider().getBill(phone: store.state.userState.phone);
    store.dispatch({"type": "BILL_ADD", "data": bill});
  };
}

ThunkAction<AppState> logout() {
  return (Store<AppState> store) async {
    await FirebaseProvider().logout();
    store.dispatch({"type": "LOGOUT"});
  };
}

ThunkAction<AppState> sendNotification() {
  return (Store<AppState> store) async {
    ApiProvider()
        .sendNotification(contacts: store.state.contactState.selectedContacts);
    //todo notify when complete;
    store.dispatch({});
  };
}
