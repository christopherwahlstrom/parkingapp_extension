class Person {
  String name;
  String personalNumber;
  Person({required this.name, required this.personalNumber});

  bool isValid() {
    final RegExp personalNumberExp = RegExp(r'^\d{10}$');
    return name.isNotEmpty && personalNumberExp.hasMatch(personalNumber);
  }
}

class Vehicle {
  String registrationNumber;
  String type;
  Person owner;

  Vehicle(
      {required this.registrationNumber,
      required this.type,
      required this.owner});

    bool isValid() {
    return registrationNumber.isNotEmpty && type.isNotEmpty && owner.isValid();
  }
}

class Parking {
  Vehicle vehicle;
  ParkingSpace parkingSpace;
  DateTime startTime;
  DateTime endTime;

  Parking(
      {required this.vehicle,
      required this.parkingSpace,
      required this.startTime,
      required this.endTime});

   bool isValid() {
    return vehicle.isValid() && parkingSpace.isValid() && startTime.isBefore(endTime);
  }

  double calculateCost() {
    final duration = endTime.difference(startTime).inHours;
    return duration * parkingSpace.pricePerHour;
  }
}

class ParkingSpace {
  String id;
  String address;
  double pricePerHour;

  ParkingSpace(
      {required this.id, required this.address, required this.pricePerHour});

  bool isValid() {
    return id.isNotEmpty && address.isNotEmpty && pricePerHour > 0;
  }
}
