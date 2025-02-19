import 'dart:io';
import '../repositories/person.dart';
import '../repositories/vehicle.dart';
import '../repositories/parking.dart';
import '../repositories/parkingspace.dart';
import 'person_menu.dart';
import 'vehicle_menu.dart';
import 'parking_space_menu.dart';
import 'parking_menu.dart';

class MainMenu {
  final PersonRepository personRepository = PersonRepository();
  final VehicleRepository vehicleRepository = VehicleRepository();
  final ParkingSpaceRepository parkingSpaceRepository = ParkingSpaceRepository();
  final ParkingRepository parkingRepository = ParkingRepository();

  void start() {
    while (true) {
      print('1. Hantera Person');
      print('2. Hantera Fordon');
      print('3. Hantera Parkingsplats');
      print('4. Hantera Parkering');
      print('5. Avsluta');
      stdout.write('Välj ett alternativ: ');
      var choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          handlePersonMenu(personRepository);
          break;
        case '2':
          handleVehicleMenu(vehicleRepository);
          break;
        case '3':
          handleParkingSpaceMenu(parkingSpaceRepository);
          break;
        case '4':
          handleParkingMenu(parkingRepository, vehicleRepository, parkingSpaceRepository);
          break;
        case '5':
          exit(0);
        default:
          print('Ogiltigt val, försök igen.');
      }
    }
  }
}