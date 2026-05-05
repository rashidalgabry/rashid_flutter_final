class Contact {
  final int? id;
  final String name;
  final String phone;

  Contact({
    this.id,
    required this.name,
    required this.phone,
  });

  // Convert object to Map (INSERT / UPDATE)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
    };
  }

  // Convert Map to Object (SELECT)
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
    );
  }
}
