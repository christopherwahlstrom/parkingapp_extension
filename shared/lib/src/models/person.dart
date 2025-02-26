import 'package:uuid/uuid.dart';

class Person {
  final String id;
  final String name;
  final String personalNumber;

  Person(this.name, this.personalNumber, [String? id]) : id = id ?? Uuid().v4();

  bool isValid() {
    return name.isNotEmpty && personalNumber.length == 10;
  }
}

class PersonEntity {
  final String id;
  final String name;
  final String personalNumber;

  PersonEntity({required this.id, required this.name, required this.personalNumber});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'personalNumber': personalNumber,
      };

  factory PersonEntity.fromJson(Map<String, dynamic> json) {
    return PersonEntity(
      id: json['id'],
      name: json['name'],
      personalNumber: json['personalNumber'],
    );
  }

  Person toDomain() {
    return Person(name, personalNumber, id);
  }

  factory PersonEntity.fromDomain(Person person) {
    return PersonEntity(
      id: person.id,
      name: person.name,
      personalNumber: person.personalNumber,
    );
  }
}