import 'dart:io';
import '../repositories/parkingspace.dart';
import '../../../shared/lib/src/models/models.dart';

void handleParkingSpaceMenu(ParkingSpaceRepository parkingSpaceRepository) {
  while (true) {
    print('Parkeringsplats meny');
    print('1. Visa parkeringsplatser');
    print('2. Lägg till parkeringsplats');
    print('3. Uppdatera parkeringsplats');
    print('4. Ta bort parkeringsplats');
    print('5. Tillbaka till huvudmenyn');

    stdout.write('Välj ett alternativ: ');
    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        viewParkingSpaces(parkingSpaceRepository);
        break;
      case '2':
        addParkingSpace(parkingSpaceRepository);
        break;
      case '3':
        updateParkingSpace(parkingSpaceRepository);
        break;
      case '4':
        removeParkingSpace(parkingSpaceRepository);
        break;
      case '5':
        return;
      default:
        print('Felaktigt val , vänligen försök igen.');
    }
  }
}

void viewParkingSpaces(ParkingSpaceRepository parkingSpaceRepository) {
  var parkingSpaces = parkingSpaceRepository.getAll();
  if (parkingSpaces.isEmpty) {
    print('Inga parkeringsplatser är lediga.');
  } else {
    for (var parkingSpace in parkingSpaces) {
      print('ID: ${parkingSpace.id}, Adress: ${parkingSpace.address}, Pris per timme: ${parkingSpace.pricePerHour}');
    }
  }
}

void addParkingSpace(ParkingSpaceRepository parkingSpaceRepository) {
  stdout.write('Skriv in parkerings platsens ID: ');
  var id = stdin.readLineSync();
  stdout.write('Skriv in adress: ');
  var address = stdin.readLineSync();
  stdout.write('Skriv in tim kostnad (SEK): ');
  var priceInput = stdin.readLineSync();

  if (id != null && address != null && priceInput != null) {
    try {
      var pricePerHour = double.parse(priceInput);
      var parkingSpace = ParkingSpace(id: id, address: address, pricePerHour: pricePerHour);
      parkingSpaceRepository.add(parkingSpace);
      print('En Parkeringsplats har framgångsrikt lagrats.');
    } catch (e) {
      print('Felaktig inmatning. Var vänlig skriv in giltiga nummer och en tim kostnad.');
    }
  } else {
    print('Felaktig inmatning. Var vänlig försök igen.');
  }
}

void updateParkingSpace(ParkingSpaceRepository parkingSpaceRepository) {
  stdout.write('Skriv in ID för parkerings plats för att uppdatera parkeringsplats: ');
  var id = stdin.readLineSync();
  var parkingSpace = parkingSpaceRepository.getById(id!);

  if (parkingSpace != null) {
    stdout.write('Skriv in ny adress: ');
    var newAddress = stdin.readLineSync();
    stdout.write('Skriv in tim kostnad: ');
    var newPriceInput = stdin.readLineSync();

    if (newAddress != null && newPriceInput != null) {
      try {
        var newPricePerHour = double.parse(newPriceInput);
        var updatedParkingSpace = ParkingSpace(id: parkingSpace.id, address: newAddress, pricePerHour: newPricePerHour);
        parkingSpaceRepository.update(parkingSpace.id, updatedParkingSpace);
        print('Parkeringsplats är uppdaterad.');
      } catch (e) {
        print('Felaktig inmatning. Vänligen skriv in ett gilltigt nummer.');
      }
    } else {
      print('Felaktig inmatning. Försök igen.');
    }
  } else {
    print('Parkingeringsplatsen hittades inte.');
  }
}

void removeParkingSpace(ParkingSpaceRepository parkingSpaceRepository) {
  stdout.write('Skriv in ID för parkeringsplats: ');
  var id = stdin.readLineSync();
  parkingSpaceRepository.delete(id!);
  print('Parkeringen togs bort framgångsrikt.');
}