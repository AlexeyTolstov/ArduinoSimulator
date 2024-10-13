int lastId = 0;

class ContactId {
  final String nameDevice;
  final String nameContact;
  late final int id;

  @override
  bool operator ==(covariant ContactId other) {
    return nameDevice == other.nameDevice && nameContact == other.nameContact;
  }

  bool isSame(ContactId other){
    return nameDevice == other.nameDevice && nameContact == other.nameContact && id == other.id; 
  }

  @override
  int get hashCode => Object.hash(nameDevice, nameContact);

  @override
  String toString() => "$nameDevice/$nameContact: $id";

  ContactId({
    required this.nameDevice,
    required this.nameContact,
  }) {
    id = lastId++;
  }
}
