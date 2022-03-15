import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:splitbill/redux/app_state.dart';

class Redux {
  static Store<AppState> _store;

  static AppState appReducer(AppState state, action) =>
      new AppState(userState: new UserState()).appReducer(state, action);

  static Store<AppState> get store {
    if (_store == null) {
      _store = Store<AppState>(
        appReducer,
        middleware: [thunkMiddleware],
        //todo setup initial state by reading the firebase auth value;
        initialState: AppState(
            userState:
                UserState(phone: "", userLoginState: UserLoginState.LOGGED_OUT),
            contactState: ContactState(
              contacts: [],
              selectedContacts: [],
              isReadingContact: true,
              contactPermissionStatus: ContactPermissionStatus.NOT_ASKED,
            ),
            billState: BillState(
              isLoading: true,
              bill: null,
            )),
      );
    }
    return _store;
  }
}
