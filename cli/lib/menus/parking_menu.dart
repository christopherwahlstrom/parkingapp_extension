import 'dart:io';
import '../../../shared/lib/src/models/models.dart';
import '../../../shared/lib/repositories/parking.dart';
import '../../../shared/lib/repositories/vehicle.dart';
import '../../../shared/lib/repositories/parkingspace.dart';

void handleParkingMenu(
    ParkingRepository parkingRepository,
    VehicleRepository vehicleRepository,
    ParkingSpaceRepository parkingSpaceRepository) {
  while (true) {
    print('1. Skapa ny Parkering');
    print('2. Visa alla Parkeringar');
    print('3. Uppdatera Parkering');
    print('4. Ta bort Parkering');
    print('5. Beräkna kostnad för Parkering');
    print('6. Tillbaka till huvudmenyn');
    stdout.write('Välj ett alternativ: ');
    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        createParking(
            parkingRepository, vehicleRepository, parkingSpaceRepository);
        break;
      case '2':
        showAllParkings(parkingRepository);
        break;
      case '3':
        updateParking(parkingRepository);
        break;
      case '4':
        deleteParking(parkingRepository);
        break;
      case '5':
        calculateParkingCost(parkingRepository);
      case '6':
        return;
      default:
        print('Ogiltigt val, försök igen.');
    }
  }
}

void createParking(
    ParkingRepository parkingRepository,
    VehicleRepository vehicleRepository,
    ParkingSpaceRepository parkingSpaceRepository) {
  stdout.write('Ange fordonets registreringsnummer: ');
  var registrationNumber = stdin.readLineSync();
  if (registrationNumber == null || registrationNumber.isEmpty) {
    print('Registreringsnummer får inte vara tomt.');
    return;
  }
  var vehicle = vehicleRepository.getByRegNr(registrationNumber);
  if (vehicle == null) {
    print('Fordonet med registreringsnummer $registrationNumber hittades inte.');
    return;
  }

  stdout.write('Ange parkeringsplatsens ID: ');
  var parkingSpaceId = stdin.readLineSync();
  if (parkingSpaceId == null || parkingSpaceId.isEmpty) {
    print('Parkeringsplatsens ID får inte vara tomt.');
    return;
  }
  var parkingSpace = parkingSpaceRepository.getById(parkingSpaceId);
  if (parkingSpace == null) {
    print('Parkeringsplatsen med ID $parkingSpaceId hittades inte.');
    return;
  }

  var parking = Parking(
    vehicle: vehicle,
    parkingSpace: parkingSpace,
    startTime: DateTime.now(),
    endTime: DateTime.now().add(Duration(hours: 1)),
  );
  if (parking.isValid()) {
    parkingRepository.add(parking);
    print('Parkering skapad.');
  } else {
    print('Ogiltig inmatning. Kontrollera att alla fält är korrekt ifyllda.');
  }
}

void showAllParkings(ParkingRepository parkingRepository) {
  var parkings = parkingRepository.getAll();
  if (parkings.isEmpty) {
    print('Inga parkeringar funna.');
  } else {
    for (var parking in parkings) {
      print(
          'Fordon: ${parking.vehicle.registrationNumber}, Parkeringsplats: ${parking.parkingSpace.id}');
    }
  }
}

void updateParking(ParkingRepository parkingRepository) {
  stdout.write('Ange registreringsnummer för fordonet som är parkerat: ');
  var registrationNumber = stdin.readLineSync();
  if (registrationNumber == null || registrationNumber.isEmpty) {
    print('Registreringsnummer får inte vara tomt.');
    return;
  }
  var parking = parkingRepository.getByVehicleRegNr(registrationNumber);

  if (parking != null) {
    stdout.write('Ange nytt sluttid ("YY:MM:DD ,  HH:MM")): ');
    var endTimeInput = stdin.readLineSync();
    if (endTimeInput != null) {
      try {
        var endTime = DateTime.parse(endTimeInput);
        parking.endTime = endTime;
        parkingRepository.update(registrationNumber, parking);
        print('Parkering uppdaterad.');
      } catch (e) {
        print('Ogiltigt datumformat.');
      }
    } else {
      print('Ogiltig input.');
    }
  } else {
    print('Parkering ej funnen.');
  }
}

void deleteParking(ParkingRepository parkingRepository) {
  stdout.write('Ange registreringsnummer för fordonet som är parkerat: ');
  var registrationNumber = stdin.readLineSync();
  parkingRepository.delete(registrationNumber!);
  print('Parkering borttagen.');
}

void calculateParkingCost(ParkingRepository parkingRepository) {
  stdout.write('Ange registreringsnummer för fordonet som är parkerat: ');
  var registrationNumber = stdin.readLineSync();
  if (registrationNumber == null || registrationNumber.isEmpty) {
    print('Registreringsnummer får inte vara tomt.');
    return;
  }
  var parking = parkingRepository.getByVehicleRegNr(registrationNumber);

  if (parking != null) {
    var cost = parking.calculateCost();
    print('Kostnaden för parkeringen är: $cost SEK');
  } else {
    print('Parkering ej funnen.');
  }
}