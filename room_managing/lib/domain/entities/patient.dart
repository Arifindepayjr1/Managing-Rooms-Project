import "../enums/gender.dart";

class Person {
  final String _name;
  final int _age;
  final Gender _gender;

  Person({required String name, required int age, required Gender gender})
    : _name = name,
      _age = age,
      _gender = gender;

  String get getUserName => _name;
  int get getAge => _age;
  Gender get getGender => _gender;
}

class Patient extends Person {
  final String _id;
  final DateTime _admittedDate;
  String? _roomId;
  String _currentCondition;
  bool _discharged;

  Patient({
    required String name,
    required int age,
    required Gender gender,
    required String id,
    String? roomId,
    required String currentCondition,
    DateTime? admittedDate,
    bool discharged = false,
  }) : _id = id,
       _roomId = roomId,
       _currentCondition = currentCondition,
       _discharged = discharged,
       _admittedDate = admittedDate ?? DateTime.now(),
       super(name: name, age: age, gender: gender);

  String get getId => _id;
  String get getCurrentCondition => _currentCondition;
  DateTime get getAdmittedDate => _admittedDate;
  bool get getDischarged => _discharged;

  void admitToRoom(String roomId) {
    if (_discharged) {
      throw Exception("Cannot admit a discharged patient");
    }
    _roomId = roomId;
  }

  void updateCurrentCondition(String newCondition) {
    _currentCondition = newCondition;
  }

  void discharged() {
    _discharged = true;
    _roomId = null;
  }

  bool isAdmitted() {
    if (_roomId == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  String toString() {
    return """
        name: $_name,
        age: $_age,
        gender: $_gender,
        personId: $_id,
        admittedDate: $_admittedDate,
        currentCondition: $_currentCondition,
        discharged: $_discharged,
    """;
  }

  Map<String, dynamic> toJson() => {
    'id': _id,
    'name': _name,
    'age': _age,
    'gender': _gender.name,
    'condition': _currentCondition,
    'admittedDate': _admittedDate.toIso8601String(),
    'discharged': _discharged,
  };

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    id: json['id'],
    name: json['name'],
    age: json['age'],
    gender: Gender.values.firstWhere((g) => g.name == json['gender']),
    roomId: json['roomId'] ?? '',
    currentCondition: json['condition'],
    admittedDate: DateTime.parse(json['admittedDate']),
    discharged: json['discharged'],
  );
}
