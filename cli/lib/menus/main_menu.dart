import 'dart:io';

import 'package:cli/utils/console.dart';
import 'package:cli/menus/person_menu.dart';
import 'package:cli/menus/vehicle_menu.dart';
import 'package:cli/menus/parking_menu.dart';
import 'package:cli/menus/parking_space_menu.dart';

class MainMenu {
  static Future prompt() async {
    Console.clear();

    while (true) {
      print('Main Menu');
      print('1. Manage Persons');
      print('2. Manage Vehicles');
      print('3. Manage Parkings');
      print('4. Manage Parking Spaces');
      print('5. Exit');
      var input = Console.choice();
      switch (input) {
        case 1:
          await PersonMenu.prompt();
        case 2:
          await VehicleMenu.prompt();
        case 3:
          await ParkingMenu.prompt();
        case 4:
          await ParkingSpaceMenu.prompt();
        case 5:
          return;
        default:
          print('Invalid choice');
      }
      print("\n------------------------------------\n");
    }
  }
}