import 'package:arduino_simulator_test/data/answer_wire.dart';
import 'package:arduino_simulator_test/data/contact_id.dart';
import 'package:arduino_simulator_test/data/wire.dart';

Answer blinkLight = Answer(answerContacts: [
  WireContacts(
    first: ContactId(nameDevice: "Light", nameContact: "VCC"),
    second: ContactId(nameDevice: "ArduinoUno", nameContact: "A0"),
  ),
  WireContacts(
    first: ContactId(nameDevice: "Light", nameContact: "GND"),
    second: ContactId(nameDevice: "ArduinoUno", nameContact: "A1"),
  ),
]);