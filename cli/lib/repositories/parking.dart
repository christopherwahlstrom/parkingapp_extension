import '../models/models.dart';

class ParkingRepository {
  final List<Parking> _parkings = [];

  void add(Parking parking) {
    _parkings.add(parking);
  }

  List<Parking> getAll() {
    return _parkings;
  }

  Parking? getByVehicleRegNr(String registrationNumber) {
    try {
      return _parkings.firstWhere(
        (parking) => parking.vehicle.registrationNumber == registrationNumber,
      );
    } catch (e) {
      return null;
    }
  }

  void update(String registrationNumber, Parking updatedParking) {
    var index = _parkings.indexWhere((parking) => parking.vehicle.registrationNumber == registrationNumber);
    if (index != -1) {
      _parkings[index] = updatedParking;
    } else {
      throw Exception('Parking with vehicle registration number $registrationNumber not found');
    }
  }

  void delete(String registrationNumber) {
    var index = _parkings.indexWhere((parking) => parking.vehicle.registrationNumber == registrationNumber);
    if (index != -1) {
      _parkings.removeAt(index);
    } else {
      throw Exception('Parking with vehicle registration number $registrationNumber not found');
    }
  }
}