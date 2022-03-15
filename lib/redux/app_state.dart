import 'package:contacts_service/contacts_service.dart';
import 'package:splitbill/models/bill.dart';
import 'package:splitbill/redux/reducer/bill_reducer.dart';
import 'package:splitbill/redux/reducer/contact_reducer.dart';
import 'package:splitbill/redux/reducer/user_reducer.dart';

//todo add every class in individual file

enum ContactPermissionStatus { NOT_ASKED, GRANTED, DENIED }

enum UserLoginState { LOGGEDIN, LOGGED_OUT, LOGGING_IN, LOGIN_FAILED }

class ContactState {
  final List<Contact> contacts;
  final List<Contact> selectedContacts;
  final ContactPermissionStatus contactPermissionStatus;
  final bool isReadingContact;
  ContactState(
      {this.contacts,
      this.contactPermissionStatus,
      this.selectedContacts,
      this.isReadingContact});

  @override
  bool operator ==(dynamic other) =>
      contactPermissionStatus == other.contactPermissionStatus &&
      contacts == other.contacts &&
      isReadingContact == other.isReadingContact &&
      selectedContacts == other.selectedContacts;

  @override
  int get hashCode =>
      contacts.hashCode ^
      selectedContacts.hashCode ^
      isReadingContact.hashCode ^
      contactPermissionStatus.hashCode;
}

class BillState {
  final Bill bill;
  final bool isLoading;

  BillState({this.bill, this.isLoading});
}

class UserState {
  final String phone;
  final UserLoginState userLoginState;
  final String error;

  @override
  bool operator ==(dynamic other) =>
      phone == other.phone &&
      error == other.error &&
      userLoginState == other.userLoginState;

  @override
  int get hashCode => phone.hashCode ^ error.hashCode ^ userLoginState.hashCode;

  UserState({this.error, this.phone, this.userLoginState});
}

class AppState {
  final UserState userState;
  final ContactState contactState;
  final BillState billState;

  AppState({this.userState, this.contactState, this.billState});

  AppState appReducer(AppState state, action) {
    return AppState(
        userState: userReducer(state.userState, action),
        contactState: contactReducer(state.contactState, action),
        billState: billReducer(state.billState, action));
  }
}
