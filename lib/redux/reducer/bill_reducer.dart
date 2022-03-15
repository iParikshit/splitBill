import 'package:splitbill/redux/app_state.dart';

BillState billReducer(BillState state, action) {
  if (action['type'] == "BILL_ADD") {
    return BillState(bill: action['data'], isLoading: false);
  }
  return BillState(bill: state.bill, isLoading: state.isLoading);
}
