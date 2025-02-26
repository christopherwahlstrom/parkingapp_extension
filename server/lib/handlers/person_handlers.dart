import 'dart:convert';
import 'package:shared/src/models/person.dart';
import 'package:shared/src/repositories/person_repository.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

PersonRepository personRepo = PersonRepository();

Future<Response> postPersonHandler(Request request) async {
  final data = await request.readAsString();
  final json = jsonDecode(data);
  var person = Person.fromJson(json);

  person = await personRepo.create(person);

  return Response.ok(
    jsonEncode(person),
    headers: {'Content-Type': 'application/json'},
  );
}

Future<Response> getPersonsHandler(Request request) async {
  final persons = await personRepo.getAll();

  final payload = persons.map((e) => e.toJson()).toList();

  return Response.ok(
    jsonEncode(payload),
    headers: {'Content-Type': 'application/json'},
  );
}

Future<Response> getPersonByIdHandler(Request request) async {
  String? id = request.params["id"];

  if (id != null) {
    var person = await personRepo.getById(id);
    if (person != null) {
      return Response.ok(
        jsonEncode(person),
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      return Response.notFound('Person not found');
    }
  }

  return Response.badRequest();
}

Future<Response> updatePersonHandler(Request request) async {
  String? id = request.params["id"];

  if (id != null) {
    final data = await request.readAsString();
    final json = jsonDecode(data);
    Person person = Person.fromJson(json);
    person = await personRepo.update(id, person);

    return Response.ok(
      jsonEncode(person),
      headers: {'Content-Type': 'application/json'},
    );
  }
  return Response.badRequest();
}

Future<Response> deletePersonHandler(Request request) async {
  String? id = request.params["id"];
  await personRepo.delete(id!);
  return Response.ok('Person deleted');
}

