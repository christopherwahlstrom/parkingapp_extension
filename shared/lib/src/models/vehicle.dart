import 'package:uuid/uuid.dart';
import 'person.dart';

class Vehicle {
  final String id;
  final String registrationNumber;
  final String type;
  final Person owner;

  Vehicle(this.registrationNumber, this.type, this.owner, [String? id]) : id = id ?? Uuid().v4();

  bool isValid() {
    return registrationNumber.isNotEmpty && type.isNotEmpty;
  }
}

class VehicleEntity {
  final String id;
  final String registrationNumber;
  final String type;
  final String ownerId;

  VehicleEntity({required this.id, required this.registrationNumber, required this.type, required this.ownerId});

  Map<String, dynamic> toJson() => {
        'id': id,
        'registrationNumber': registrationNumber,
        'type': type,
        'ownerId': ownerId,
      };

  factory VehicleEntity.fromJson(Map<String, dynamic> json) {
    return VehicleEntity(
      id: json['id'],
      registrationNumber: json['registrationNumber'],
      type: json['type'],
      ownerId: json['ownerId'],
    );
  }

  Future<Vehicle> toDomain(PersonRepository personRepository) async {
    var owner = await personRepository.getById(ownerId);
    if (owner != null) {
      return Vehicle(registrationNumber, type, owner, id);
    } else {
      throw Exception('Owner not found');
    }
  }

  factory VehicleEntity.fromDomain(Vehicle vehicle) {
    return VehicleEntity(
      id: vehicle.id,
      registrationNumber: vehicle.registrationNumber,
      type: vehicle.type,
      ownerId: vehicle.owner.id,
    );
  }
}