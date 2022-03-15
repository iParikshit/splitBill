import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:splitbill/redux/action_dispatcher.dart';
import 'package:splitbill/redux/app_state.dart';
import 'package:splitbill/ui/split_screen/components/selected_contact_list.dart';
import 'package:splitbill/util/constants.dart';

import 'bill_widget.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);
    return SliverFillRemaining(
      child: Column(
        children: [
          SelectedContactList(),
          Expanded(child: BillWidget()),
          StoreConnector<AppState, ContactState>(
            converter: (store) => store.state.contactState,
            distinct: true,
            builder: (context, contactState) {
              return Container(
                width: MediaQuery.of(context).size.width,
                color: kGreenColor,
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(kGreenColor),
                  ),
                  onPressed: contactState.selectedContacts.length == 0
                      ? null
                      : () {
                          store.dispatch(sendNotification());
                        },
                  child: Text("Split"),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
