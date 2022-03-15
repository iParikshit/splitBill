import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactProvider {
  //todo create singleton class

  readContacts(
      {Function onPermissionNotGranted, Function onPermissionGranted}) async {
    await Permission.contacts.request();
    var permissionStatus = await _getPermission();
    if (permissionStatus == PermissionStatus.granted) {
      //We can now access our contacts here
      var contacts = await ContactsService.getContacts();
      onPermissionGranted(contacts.toList());
    } else {
      //todo handle permission not granted
      onPermissionNotGranted();
    }
  }

  _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.denied;
    } else {
      return permission;
    }
  }
}
