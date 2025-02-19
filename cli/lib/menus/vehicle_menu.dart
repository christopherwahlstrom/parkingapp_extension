import 'dart:io';
import '../models/models.dart';
import '../repositories/vehicle.dart';

void handleVehicleMenu(VehicleRepository vehicleRepository) {
  while (true) {
    print('1. Lägg till fordon');
    print('2. Visa alla fordon');
    print('3. Uppdatera fordon');
    print('4. Ta bort fordon');
    print('5. Sök efter fordon');
    print('6. Tillbaka till huvudmenyn');
    stdout.write('Välj ett alternativ: ');
    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        addVehicle(vehicleRepository);
        break;
      case '2':
        viewVehicles(vehicleRepository);
        break;
      case '3':
        updateVehicle(vehicleRepository);
        break;
      case '4':
        deleteVehicle(vehicleRepository);
        break;
      case '5':
        searchVehicleByOwner(vehicleRepository);
        break;
      case '6':
        return;
      default:
        print('Felaktigt val, försök igen.');
    }
  }
}

void addVehicle(VehicleRepository vehicleRepository) async {
  stdout.write('Skriv in Registrerings nummer: ');
  var registrationNumber = stdin.readLineSync();
  stdout.write('Skriv in fordonstyp (Ex. Bil , Motorcykel): ');
  var type = stdin.readLineSync();
  stdout.write('Skriv in ägarens namn: ');
  var ownerName = stdin.readLineSync();
  stdout.write('Skriv in ägarens personnummer: ');
  var ownerPersonalNumber = stdin.readLineSync();

  if (registrationNumber != null && type != null && ownerName != null && ownerPersonalNumber != null) {
    var owner = Person(name: ownerName, personalNumber: ownerPersonalNumber);
    var vehicle = Vehicle(registrationNumber: registrationNumber, type: type, owner: owner);
    if (vehicle.isValid()) {
      vehicleRepository.add(vehicle);
      print('Fordon tillagt.');
    } else {
      print('Ogiltig inmatning. Kontrollera att alla fält är korrekt ifyllda.');
    }
  } else {
    print('Ogiltig input.');
  }
}

void viewVehicles(VehicleRepository vehicleRepository) {
  var vehicles = vehicleRepository.getAll();
  if (vehicles.isEmpty) {
    print('Inga fordon är tillgängliga.');
  } else {
    for (var vehicle in vehicles) {
      print('Registrerings nummer: ${vehicle.registrationNumber}, Fordons typ: ${vehicle.type}, Ägare: ${vehicle.owner.name}');
    }
  }
}

void updateVehicle(VehicleRepository vehicleRepository) {
  stdout.write('Skriv in fordonets registerings nummer för att uppdatera: ');
  var registrationNumber = stdin.readLineSync();
  var vehicle = vehicleRepository.getByRegNr(registrationNumber!);

  if (vehicle != null) {
    stdout.write('Skriv in nytt fordonsval: ');
    var newType = stdin.readLineSync();
    stdout.write('Skriv i ny ägare: ');
    var newOwnerName = stdin.readLineSync();
    var newOwner = Person(name: newOwnerName ?? '', personalNumber: '');

    if (newType != null && newOwnerName != null) {
      vehicle.type = newType;
      vehicle.owner = newOwner;
      vehicleRepository.update(registrationNumber, vehicle);
      print('Fordonet har framgångsrikt uppdaterats.');
    } else {
      print('Felaktig inmatning. Vänligen försök igen.');
    }
  } else {
    print('Fordonet har uppdaterats.');
  }
}

void deleteVehicle(VehicleRepository vehicleRepository) {
  stdout.write('Skriv in fordonets registreringsnummer för att radera: ');
  var registrationNumber = stdin.readLineSync();
  vehicleRepository.delete(registrationNumber!);
  print('Fordonet är raderat.');
}

void searchVehicleByOwner(VehicleRepository vehicleRepository) {
  stdout.write('Ange ägarens namn: ');
  var owner = stdin.readLineSync();
  if (owner == null || owner.isEmpty) {
    print('Ägarens namn får inte vara tomt.');
    return;
  }
  var vehicles = vehicleRepository.getByOwner(owner);
  if (vehicles.isEmpty) {
    print('Inga fordon funna för ägaren $owner.');
  } else {
    for (var vehicle in vehicles) {
      print('Registreringsnummer: ${vehicle.registrationNumber}, Typ: ${vehicle.type}, Ägare: ${vehicle.owner.name}');
    }
  }
}