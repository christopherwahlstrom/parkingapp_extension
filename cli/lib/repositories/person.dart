import '../models/models.dart';

class PersonRepository {
  final List<Person> _persons = [];

    void add(Person person) {
      _persons.add(person);
    }

    List<Person> getAll() {
      return _persons;
    }

    Person? getById(String personalNumber) {
      try {
        return _persons.firstWhere(
          (person) => person.personalNumber == personalNumber,
        );
      } catch (e) {
        return null; 
      }
    }

    void update(String personalNumber, Person updatedPerson) {
    var index = _persons.indexWhere((person) => person.personalNumber == personalNumber);
    if (index != -1) {
      _persons[index] = updatedPerson;
    } else {
      throw Exception('Person with personal number $personalNumber not found');
    }
  }

  void delete(String personalNumber) {
    var index = _persons.indexWhere((person) => person.personalNumber == personalNumber);
    if (index != -1) {
      _persons.removeAt(index);
    } else {
      throw Exception('Person with personal number $personalNumber not found');
    }
  }
}
