import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:splitbill/redux/action_dispatcher.dart';
import 'package:splitbill/redux/app_state.dart';

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(),
      body: StoreConnector<AppState, ContactState>(
        converter: (store) {
          return store.state.contactState;
        },
        builder: (context, contactState) {
          return contactState.isReadingContact
              ? Center(
                  child: Text(
                    "Reading Contacts...",
                  ),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: contactState.contacts[index].avatar.length != 0
                              ? Image.memory(
                                  contactState.contacts[index].avatar,
                                  width: 55,
                                  height: 55,
                                )
                              //todo store image path in a global constant
                              : Image.asset(
                                  'assets/images/blank-contact.png',
                                  width: 55,
                                  height: 55,
                                ),
                        ),
                        title: Text(contactState.contacts[index].displayName),
                        onTap: () {
                          store.dispatch(
                              selectContact(contactState.contacts[index]));
                        },
                        selected: contactState.selectedContacts
                            .contains(contactState.contacts[index]),
                      ),
                    );
                  },
                  itemCount: contactState.contacts.length,
                );
        },
      ),
    );
  }
}
