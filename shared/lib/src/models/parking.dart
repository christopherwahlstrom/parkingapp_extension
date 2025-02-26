import 'package:uuid/uuid.dart';
import 'vehicle.dart';
import 'parking_space.dart';

class Parking {
  final String id;
  final Vehicle vehicle;
  final ParkingSpace parkingSpace;
  final DateTime startTime;
  final DateTime? endTime;

  Parking(this.vehicle, this.parkingSpace, this.startTime, [this.endTime, String? id]) : id = id ?? Uuid().v4();

  bool isValid() {
    return startTime.isBefore(DateTime.now()) && (endTime == null || endTime!.isAfter(startTime));
  }
}

class ParkingEntity {
  final String id;
  final String vehicleId;
  final String parkingSpaceId;
  final DateTime startTime;
  final DateTime? endTime;

  ParkingEntity({required this.id, required this.vehicleId, required this.parkingSpaceId, required this.startTime, this.endTime});

  Map<String, dynamic> toJson() => {
        'id': id,
        'vehicleId': vehicleId,
        'parkingSpaceId': parkingSpaceId,
        'startTime': startTime.toIso8601String(),
        if (endTime != null) 'endTime': endTime!.toIso8601String(),
      };

  factory ParkingEntity.fromJson(Map<String, dynamic> json) {
    return ParkingEntity(
      id: json['id'],
      vehicleId: json['vehicleId'],
      parkingSpaceId: json['parkingSpaceId'],
      startTime: DateTime.parse(json['startTime']),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
    );
  }

  Future<Parking> toDomain(VehicleRepository vehicleRepository, ParkingSpaceRepository parkingSpaceRepository) async {
    var vehicle = await vehicleRepository.getById(vehicleId);
    var parkingSpace = await parkingSpaceRepository.getById(parkingSpaceId);
    if (vehicle != null && parkingSpace != null) {
      return Parking(vehicle, parkingSpace, startTime, endTime, id);
    } else {
      throw Exception('Vehicle or Parking Space not found');
    }
  }

  factory ParkingEntity.fromDomain(Parking parking) {
    return ParkingEntity(
      id: parking.id,
      vehicleId: parking.vehicle.id,
      parkingSpaceId: parking.parkingSpace.id,
      startTime: parking.startTime,
      endTime: parking.endTime,
    );
  }
}