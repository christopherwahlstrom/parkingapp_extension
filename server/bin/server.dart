import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shared/lib/src/shared.dart';

class ServerConfig {
  ServerConfig._privateConstructor() {
    initialize();
  }

  static final ServerConfig _instance = ServerConfig._privateConstructor();
  static ServerConfig get instance => _instance;

  late Router router;

  Future initialize() async {
    router = Router();

    router.post('/persons', postPersonHandler);
    router.get('/persons', getPersonsHandler);
    router.get('/persons/<id>', getPersonByIdHandler);
    router.put('/persons/<id>', updatePersonHandler);
    router.delete('/persons/<id>', deletePersonHandler);

    router.post('/vehicles', postVehicleHandler);
    router.get('/vehicles', getVehiclesHandler);
    router.get('/vehicles/<id>', getVehicleByIdHandler);
    router.put('/vehicles/<id>', updateVehicleHandler);
    router.delete('/vehicles/<id>', deleteVehicleHandler);

    router.post('/parkingspaces', postParkingSpaceHandler);
    router.get('/parkingspaces', getParkingSpacesHandler);
    router.get('/parkingspaces/<id>', getParkingSpaceByIdHandler);
    router.put('/parkingspaces/<id>', updateParkingSpaceHandler);
    router.delete('/parkingspaces/<id>', deleteParkingSpaceHandler);

    router.post('/parkings', postParkingHandler);
    router.get('/parkings', getParkingsHandler);
    router.get('/parkings/<id>', getParkingByIdHandler);
    router.put('/parkings/<id>', updateParkingHandler);
    router.delete('/parkings/<id>', deleteParkingHandler);

  }

}
