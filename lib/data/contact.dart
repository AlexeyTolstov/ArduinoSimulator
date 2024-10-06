import 'package:arduino_simulator_test/data/contact_id.dart';
import 'package:arduino_simulator_test/data/position.dart';

class Contact {
  final ContactId contactId;

  final Position pos;
  late void Function() onTap;
  
  bool isSelected;

  set setFunction(void Function() onTap) => this.onTap = onTap;

  Contact({
    required this.contactId,
    required this.pos,
    this.isSelected = false,
  });
}