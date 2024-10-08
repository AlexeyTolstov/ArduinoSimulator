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

  static List<Contact> arduinoUnoContacts = [
    Contact(
      contactId: ContactId(nameDevice: "ArduinoUno", nameContact: "A5"),
      pos: Position(right: 33, bottom: 23),
    ),
    Contact(
      contactId: ContactId(nameDevice: "ArduinoUno", nameContact: "A4"),
      pos: Position(right: 51, bottom: 23),
    ),
    Contact(
      contactId: ContactId(nameDevice: "ArduinoUno", nameContact: "A3"),
      pos: Position(right: 69, bottom: 23),
    ),
    Contact(
      contactId: ContactId(nameDevice: "ArduinoUno", nameContact: "A2"),
      pos: Position(right: 86, bottom: 23),
    ),
    Contact(
      contactId: ContactId(nameDevice: "ArduinoUno", nameContact: "A1"),
      pos: Position(right: 104, bottom: 23),
    ),
    Contact(
      contactId: ContactId(nameDevice: "ArduinoUno", nameContact: "A0"),
      pos: Position(right:122, bottom: 23),
    ),
  ];
}
