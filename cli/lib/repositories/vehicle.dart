import '../models/models.dart';

class VehicleRepository {
  final List<Vehicle> _vehicles = [];

  void add(Vehicle vehicle) {
    _vehicles.add(vehicle);
  }

  List<Vehicle> getAll() {
    return _vehicles;
  }

  Vehicle? getByRegNr(String regNr) {
    try {
      return _vehicles.firstWhere(
        (vehicle) => vehicle.registrationNumber == regNr,
      );
    } catch (e) {
      return null;
    }
  }

  List<Vehicle> getByOwner(String ownerName) {
    return _vehicles.where((vehicle) => vehicle.owner.name == ownerName).toList();
  }

  void update(String registrationNumber, Vehicle updatedVehicle) {
    var index =
        _vehicles.indexWhere((vehicle) => vehicle.registrationNumber == registrationNumber);
    if (index != -1) {
      _vehicles[index] = updatedVehicle;
    } else {
      throw Exception('Vehicle with registration number $registrationNumber not found');
    }
  }

  void delete(String registrationNumber) {
    var index =
        _vehicles.indexWhere((vehicle) => vehicle.registrationNumber == registrationNumber);
    if (index != -1) {
      _vehicles.removeAt(index);
    } else {
      throw Exception('Vehicle with registration number $registrationNumber not found');
    }
  }
}
