import 'package:uuid/uuid.dart';

class ParkingSpace {
  final String id;
  final String address;
  final double pricePerHour;

  ParkingSpace(this.address, this.pricePerHour, [String? id]) : id = id ?? Uuid().v4();

  bool isValid() {
    return address.isNotEmpty && pricePerHour > 0;
  }
}

class ParkingSpaceEntity {
  final String id;
  final String address;
  final double pricePerHour;

  ParkingSpaceEntity({required this.id, required this.address, required this.pricePerHour});

  Map<String, dynamic> toJson() => {
        'id': id,
        'address': address,
        'pricePerHour': pricePerHour,
      };

  factory ParkingSpaceEntity.fromJson(Map<String, dynamic> json) {
    return ParkingSpaceEntity(
      id: json['id'],
      address: json['address'],
      pricePerHour: json['pricePerHour'],
    );
  }

  ParkingSpace toDomain() {
    return ParkingSpace(address, pricePerHour, id);
  }

  factory ParkingSpaceEntity.fromDomain(ParkingSpace parkingSpace) {
    return ParkingSpaceEntity(
      id: parkingSpace.id,
      address: parkingSpace.address,
      pricePerHour: parkingSpace.pricePerHour,
    );
  }
}