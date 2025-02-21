class Person {
  final String id;
  final String name;
  final String personalNumber;

  Person({required this.id, required this.name, required this.personalNumber});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      personalNumber: json['personalNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'personalNumber': personalNumber,
    };
  }

  bool isValid() {
    final RegExp personalNumberExp = RegExp(r'^\d{10}$');
    return name.isNotEmpty && personalNumberExp.hasMatch(personalNumber);
  }
}

class Vehicle {
  final String id;
  final String registrationNumber;
  final String type;
  final Person owner;
  

  Vehicle(
      {
      required this.id,  
      required this.registrationNumber,
      required this.type,
      required this.owner});

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      registrationNumber: json['registrationNumber'],
      type: json['type'],
      owner: Person.fromJson(json['owner']),
    );
  }

  bool isValid() {
    return registrationNumber.isNotEmpty && type.isNotEmpty && owner.isValid();
  }
}

class Parking {
  final String id;
  final Vehicle vehicle;
  final ParkingSpace parkingSpace;
  final DateTime startTime;
  final DateTime endTime;


  Parking(
      {
      required this.id,
      required this.vehicle,
      required this.parkingSpace,
      required this.startTime,
      required this.endTime});

  factory Parking.fromJson(Map<String, dynamic> json) {
    return Parking(
      id: json['id'],
      vehicle: Vehicle.fromJson(json['vehicle']),
      parkingSpace: ParkingSpace.fromJson(json['parkingSpace']),
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
    );
  }

  bool isValid() {
    return vehicle.isValid() &&
        parkingSpace.isValid() &&
        startTime.isBefore(endTime);
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
