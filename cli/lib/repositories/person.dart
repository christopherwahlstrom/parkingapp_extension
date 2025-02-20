import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../shared/lib/src/models/models.dart';
import '../../../shared/lib/src/repositories/repository_interface.dart';

class PersonRepository implements RepositoryInterface<Person> {
  final String baseURL;

  PersonRepository(this.baseURL);

  @override
  Future<Person> create(Person person) async {
    final uri = Uri.parse('$baseUrl/persons');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(person.toJson()),
    );

    if (response.statusCode == 201) {
      return Person.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Lyckades inte skapa person');
    }
  }

  @override
  Future<List<Person>> getAll() async {
    final uri = Uri.parse('$baseUrl/persons');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final persons = jsonDecode(response.body) as List;
      return persons.map((person) => Person.fromJson(person)).toList();
    } else {
      throw Exception('Lyckades inte hämta personer');
    }
  }

  @override
  Future<Person?> getById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/persons/$id'));
    if (response.statusCode == 200) {
      return Person.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  @override
  Future<void> update(String id, Person person) async {
    final response = await http.put(
      Uri.parse('$baseUrl/persons/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(person.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Misslyckades att uppdatera person');
    }
  }

  @override
  Future<void> delete(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/persons/$id'));
    if (response.statusCode != 200) {
      throw Exception('Misslyckades att ta bort person');
    }
  }
}