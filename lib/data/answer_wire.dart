import 'package:arduino_simulator_test/data/wire.dart';

class Answer {
  final List<WireContacts> answerContacts;

  @override
  bool operator ==(covariant Answer other) {
    if (other.answerContacts.length != answerContacts.length) return false;

    for (WireContacts i in other.answerContacts) {
      bool isHave = false;

      for (WireContacts j in answerContacts) {
        if (i == j) {
          isHave = true;
          break;
        }
      }

      if (!isHave) {
        return false;
      }
    }
    return true;
  }

  @override
  String toString() => answerContacts.toString();

  Answer({required this.answerContacts});
}