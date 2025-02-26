import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared/src/models/person.dart';
import 'package:shared/repositories/repository_interface.dart';

class PersonRepository implements RepositoryInterface<Person> {
  final String baseUrl;

  PersonRepository({this.baseUrl = 'http://localhost:8080'});

  @override
  Future<Person> create(Person person) async {
    final response = await http.post(
      Uri.parse('$baseUrl/persons'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(person.toJson()),
    );
    if (response.statusCode == 200) {
      return Person.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create person');
    }
  }

  @override
  Future<List<Person>> getAll() async {
    final response = await http.get(Uri.parse('$baseUrl/persons'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Person.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load persons');
    }
  }

  @override
  Future<Person?> getById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/persons/$id'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Person.fromJson(data);
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to load person');
    }
  }

  @override
  Future<Person> update(String id, Person person) async {
    final response = await http.put(
      Uri.parse('$baseUrl/persons/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(person.toJson()),
    );
    if (response.statusCode == 200) {
      return Person.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update person');
    }
  }

  @override
  Future<void> delete(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/persons/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete person');
    }
  }
}