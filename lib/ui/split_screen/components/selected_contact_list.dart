import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:splitbill/redux/action_dispatcher.dart';
import 'package:splitbill/redux/app_state.dart';
import 'package:splitbill/ui/contact_list_screen/contact_list_screen.dart';

class SelectedContactList extends StatelessWidget {
  const SelectedContactList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);

    return StoreConnector<AppState, ContactState>(
      distinct: true,
      converter: (store) {
        // print(store.state.userState);
        return store.state.contactState;
      },
      builder: (context, contactState) {
        print('selected contact list rebuild');
        return Container(
          //todo show loading while reading contacts
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              //todo code refactoring
              if (index == contactState.selectedContacts.length) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffE9C88B),
                        ),
                        height: 50,
                        width: 50,
                        child: IconButton(
                          onPressed: () {
                            //todo navigate to next screen to choose contacts from.
                            if (contactState.contacts.length == 0) {
                              store.dispatch(readContacts());
                            }
                            Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) {
                                return ContactListScreen();
                              },
                            ));
                          },
                          icon: Icon(CupertinoIcons.plus),
                        ),
                      ),
                      Text(
                        "Add To Group",
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ClipRRect(
                      child:
                          contactState.selectedContacts[index].avatar.length !=
                                  0
                              ? Image.memory(
                                  contactState.selectedContacts[index].avatar,
                                  height: 50,
                                  width: 50,
                                  //todo save assets path in const
                                )
                              : Image.asset(
                                  'assets/images/blank-contact.png',
                                  height: 50,
                                  width: 50,
                                ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    Text(
                      contactState.selectedContacts[index].displayName,
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              );
            },
            itemCount: contactState.selectedContacts.length + 1,
          ),
        );
      },
    );
  }
}
