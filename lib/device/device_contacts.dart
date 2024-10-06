import 'package:arduino_simulator_test/data/contact.dart';
import 'package:arduino_simulator_test/data/contact_id.dart';
import 'package:arduino_simulator_test/data/position.dart';

abstract class DeviceContacts {
  static List<Contact> lightContacts = [
    Contact(
      contactId: ContactId(nameDevice: "Light", nameContact: "GND"),
      pos: Position(left: 6, bottom: 0),
    ),
    Contact(
      contactId: ContactId(nameDevice: "Light", nameContact: "VCC"),
      pos: Position(right: 5, bottom: 0),
    ),
  ];
}
