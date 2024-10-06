class ContactId {
  final String nameDevice;
  final String nameContact;

  @override
  bool operator ==(covariant ContactId other) {
    return nameDevice == other.nameDevice && nameContact == other.nameContact;
  }

  @override
  int get hashCode => Object.hash(nameDevice, nameContact);

  @override
  String toString() => "$nameDevice/$nameContact";

  ContactId({
    required this.nameDevice,
    required this.nameContact,
  });
}
