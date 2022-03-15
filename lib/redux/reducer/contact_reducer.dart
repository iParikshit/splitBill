import 'package:contacts_service/contacts_service.dart';
import 'package:splitbill/redux/app_state.dart';

ContactState contactReducer(ContactState state, action) {
  if (action['type'] == 'READ_CONTACTS') {
    return ContactState(
      contacts: action['data'],
      selectedContacts: state.selectedContacts,
      isReadingContact: false,
    );
  }
  if (action['type'] == "READING_CONTACT") {
    return ContactState(
      contacts: [...state.contacts],
      isReadingContact: true,
    );
  }
  if (action['type'] == 'SELECT_CONTACT') {
    print('select contact');
    Contact contact = action['data'];
    List<Contact> selectedContact = [...state.selectedContacts];
    if (selectedContact.contains(contact)) {
      selectedContact.remove(contact);
    } else {
      selectedContact.add(contact);
    }
    return ContactState(
      contacts: state.contacts,
      selectedContacts: selectedContact,
      isReadingContact: false,
    );
  }
  return ContactState(
    selectedContacts: state.selectedContacts,
    contacts: state.contacts,
    contactPermissionStatus: state.contactPermissionStatus,
    isReadingContact: state.isReadingContact,
  );
}
