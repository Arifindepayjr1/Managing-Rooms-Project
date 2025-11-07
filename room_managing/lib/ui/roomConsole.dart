import 'dart:io';
import 'package:nanoid/nanoid.dart';
import '../domain/entities/patient.dart';
import '../domain/enums/gender.dart';
import '../domain/services/admissionService.dart';
import "../domain/enums/room_type.dart";

class RoomConsole {
  final Admissionservice admissionservice;

  RoomConsole({required this.admissionservice});

  Future<void> start() async {
    while (true) {
      _clearScreen();
      print('''
==================================================
          HOSPITAL ROOM MANAGEMENT SYSTEM
==================================================
1. Admit New Patient
2. Discharge Patient
3. Display All Available Rooms
4. Display All Patients
5. Exit
==================================================
Enter your choice: 
''');

      String? choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          await _admitPatient();
          break;
        case '2':
          await _dischargePatient();
          break;
        case '3':
          await _viewRooms();
          break;
        case '4':
          await _viewPatients();
          break;
        case '5':
          print("Exiting system... Goodbye!");
          return;
        default:
          print("Invalid option. Press Enter to try again.");
          stdin.readLineSync();
      }
    }
  }

  Future<void> _admitPatient() async {
    _clearScreen();
    print("============== Admit New Patient ==============\n");

    stdout.write("Enter patient name: ");
    String name = stdin.readLineSync() ?? "";

    stdout.write("Enter patient age: ");
    int age = int.tryParse(stdin.readLineSync() ?? "") ?? 0;

    stdout.write("Enter gender (male/female): ");
    String genderInput = (stdin.readLineSync() ?? "").toLowerCase();
    Gender gender = genderInput == "female" ? Gender.female : Gender.male;

    stdout.write("Enter current condition: ");
    String condition = stdin.readLineSync() ?? "";

    RoomType? roomType;
    await _viewRooms();
    while (true) {
      stdout.write(
        "\nAssign To Room Type (1 = General, 2 = ICU, 3 = Isolation, 4 = Private): ",
      );
      String? roomTypeInput = stdin.readLineSync();
      switch (roomTypeInput) {
        case "1":
          roomType = RoomType.general;
          break;
        case "2":
          roomType = RoomType.icu;
          break;
        case "3":
          roomType = RoomType.isolation;
          break;
        case "4":
          roomType = RoomType.private;
          break;
        default:
          roomType = null;
          print("Invalid input. Try again.");
      }

      if (roomType != null) break;
    }

    final id = nanoid(8);

    final patient = Patient(
      id: id.toString(),
      name: name,
      age: age,
      gender: gender,
      roomId: '',
      currentCondition: condition,
    );

    try {
      await admissionservice.admitPatient(patient, roomType);
      print("\nPatient '${patient.getUserName}' admitted successfully!");
    } catch (e) {
      print("\nError admitting patient: $e");
    }

    _pause();
  }

  Future<void> _dischargePatient() async {
    _clearScreen();
    print("============== Discharge Patient ==============\n");

    await _viewPatients();

    stdout.write("\nEnter patient ID to discharge: ");
    String? id = stdin.readLineSync();

    late Patient patient;

    try {
      patient = await admissionservice.viewPatientById(id!);
    } catch (error) {
      print("\n$error");
      _pause();
      return;
    }

    try {
      await admissionservice.dischargedPatient(patient);
      patient.discharged();
      print("\nPatient discharged successfully!");
    } catch (e) {
      print("\nError discharging patient: $e");
    }

    _pause();
  }

  Future<void> _viewPatients() async {
    _clearScreen();
    print("============== Current Patients ==============\n");

    try {
      final List<Patient> patients = await admissionservice
          .viewAllPatientOccupy();

      if (patients.isEmpty) {
        print("No patients currently occupying beds.\n");
        return;
      }

      print(
        "+------------+----------------------+---------+-----------+-------------------------+",
      );
      print(
        "| Patient ID | Name                 | Gender  | Age       | Condition               |",
      );
      print(
        "+------------+----------------------+---------+-----------+-------------------------+",
      );

      for (var p in patients) {
        print(
          "| ${p.getId.padRight(10)} | ${p.getUserName.padRight(20)} | ${p.getGender.name.padRight(7)} | ${p.getAge.toString().padRight(9)} | ${p.getCurrentCondition.padRight(23)} |",
        );
      }

      print(
        "+------------+----------------------+---------+-----------+-------------------------+",
      );
    } catch (_) {
      print("No patients currently occupying beds.\n");
    }

    _pause();
  }

  Future<void> _viewRooms() async {
    _clearScreen();
    print("============== Room and Bed Status ==============\n");

    try {
      final rooms = await admimport 'dart:io';
import 'package:nanoid/nanoid.dart';
import '../domain/entities/patient.dart';
import '../domain/enums/gender.dart';
import '../domain/services/admissionService.dart';
import "../domain/enums/room_type.dart";

class RoomConsole {
  final Admissionservice admissionservice;

  RoomConsole({required this.admissionservice});

  Future<void> start() async {
    while (true) {
      _clearScreen();
      print('''
==================================================
          HOSPITAL ROOM MANAGEMENT SYSTEM
==================================================
1. Admit New Patient
2. Discharge Patient
3. Display All Available Rooms
4. Display All Patients
5. Exit
==================================================
Enter your choice: 
''');

      String? choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          await _admitPatient();
          break;
        case '2':
          await _dischargePatient();
          break;
        case '3':
          await _viewRooms();
          break;
        case '4':
          await _viewPatients();
          break;
        case '5':
          print("Exiting system... Goodbye!");
          return;
        default:
          print("Invalid option. Press Enter to try again.");
          stdin.readLineSync();
      }
    }
  }

  Future<void> _admitPatient() async {
    _clearScreen();
    print("============== Admit New Patient ==============\n");

    stdout.write("Enter patient name: ");
    String name = stdin.readLineSync() ?? "";

    stdout.write("Enter patient age: ");
    int age = int.tryParse(stdin.readLineSync() ?? "") ?? 0;

    stdout.write("Enter gender (male/female): ");
    String genderInput = (stdin.readLineSync() ?? "").toLowerCase();
    Gender gender = genderInput == "female" ? Gender.female : Gender.male;

    stdout.write("Enter current condition: ");
    String condition = stdin.readLineSync() ?? "";

    RoomType? roomType;
    await _viewRooms();
    while (true) {
      stdout.write(
        "\nAssign To Room Type (1 = General, 2 = ICU, 3 = Isolation, 4 = Private): ",
      );
      String? roomTypeInput = stdin.readLineSync();
      switch (roomTypeInput) {
        case "1":
          roomType = RoomType.general;
          break;
        case "2":
          roomType = RoomType.icu;
          break;
        case "3":
          roomType = RoomType.isolation;
          break;
        case "4":
          roomType = RoomType.private;
          break;
        default:
          roomType = null;
          print("Invalid input. Try again.");
      }

      if (roomType != null) break;
    }

    final id = nanoid(8);

    final patient = Patient(
      id: id.toString(),
      name: name,
      age: age,
      gender: gender,
      roomId: '',
      currentCondition: condition,
    );

    try {
      await admissionservice.admitPatient(patient, roomType);
      print("\nPatient '${patient.getUserName}' admitted successfully!");
    } catch (e) {
      print("\nError admitting patient: $e");
    }

    _pause();
  }

  Future<void> _dischargePatient() async {
    _clearScreen();
    print("============== Discharge Patient ==============\n");

    await _viewPatients();

    stdout.write("\nEnter patient ID to discharge: ");
    String? id = stdin.readLineSync();

    late Patient patient;

    try {
      patient = await admissionservice.viewPatientById(id!);
    } catch (error) {
      print("\n$error");
      _pause();
      return;
    }

    try {
      await admissionservice.dischargedPatient(patient);
      patient.discharged();
      print("\nPatient discharged successfully!");
    } catch (e) {
      print("\nError discharging patient: $e");
    }

    _pause();
  }

  Future<void> _viewPatients() async {
    _clearScreen();
    print("============== Current Patients ==============\n");

    try {
      final List<Patient> patients = await admissionservice
          .viewAllPatientOccupy();

      if (patients.isEmpty) {
        print("No patients currently occupying beds.\n");
        return;
      }

      print(
        "+------------+----------------------+---------+-----------+-------------------------+",
      );
      print(
        "| Patient ID | Name                 | Gender  | Age       | Condition               |",
      );
      print(
        "+------------+----------------------+---------+-----------+-------------------------+",
      );

      for (var p in patients) {
        print(
          "| ${p.getId.padRight(10)} | ${p.getUserName.padRight(20)} | ${p.getGender.name.padRight(7)} | ${p.getAge.toString().padRight(9)} | ${p.getCurrentCondition.padRight(23)} |",
        );
      }

      print(
        "+------------+----------------------+---------+-----------+-------------------------+",
      );
    } catch (_) {
      print("No patients currently occupying beds.\n");
    }

    _pause();
  }

  Future<void> _viewRooms() async {
    _clearScreen();
    print("============== Room and Bed Status ==============\n");

    try {
      final rooms = await admissionservice.viewAllRoom();

      for (var room in rooms) {
        print("\nRoom ID: ${room.getId}");
        print("Room Type: ${room.getRoomType.name}");
        print(
          "+-----------+-------------+----------------------+------------------+",
        );
        print(
          "| Bed ID    | Bed Status  | Patient Name         | Patient Condition |",
        );
        print(
          "+-----------+-------------+----------------------+------------------+",
        );

        for (var bed in room.getAvailableBed()) {
          final patientName = bed.getPatient != null
              ? bed.getPatient!.getUserName
              : "-";
          final condition = bed.getPatient != null
              ? bed.getPatient!.getCurrentCondition
              : "-";
          print(
            "| ${bed.getId.padRight(9)} | ${bed.getBedStatus.name.padRight(11)} | ${patientName.padRight(20)} | ${condition.padRight(16)} |",
          );
        }

        print(
          "+-----------+-------------+----------------------+------------------+\n",
        );
      }
    } catch (_) {
      print("No room information available.");
    }

    _pause();
  }

  void _pause() {
    stdout.write("\nPress Enter to continue...");
    stdin.readLineSync();
  }

  void _clearScreen() {
    if (Platform.isWindows) {
      stdout.write('\x1B[2J\x1B[0;0H');
    } else {
      stdout.write('\x1B[2J\x1B[H');
    }
  }
}

issionservice.viewAllRoom();

      for (var room in rooms) {
        print("\nRoom ID: ${room.getId}");
        print("Room Type: ${room.getRoomType.name}");
        print(
          "+-----------+-------------+----------------------+------------------+",
        );
        print(
          "| Bed ID    | Bed Status  | Patient Name         | Patient Condition |",
        );
        print(
          "+-----------+-------------+----------------------+------------------+",
        );

        for (var bed in room.getAvailableBed()) {
          final patientName = bed.getPatient != null
              ? bed.getPatient!.getUserName
              : "-";
          final condition = bed.getPatient != null
              ? bed.getPatient!.getCurrentCondition
              : "-";
          print(
            "| ${bed.getId.padRight(9)} | ${bed.getBedStatus.name.padRight(11)} | ${patientName.padRight(20)} | ${condition.padRight(16)} |",
          );
        }

        print(
          "+-----------+-------------+----------------------+------------------+\n",
        );
      }
    } catch (_) {
      print("No room information available.");
    }

    _pause();
  }

  void _pause() {
    stdout.write("\nPress Enter to continue...");
    stdin.readLineSync();
  }

  void _clearScreen() {
    if (Platform.isWindows) {
      stdout.write('\x1B[2J\x1B[0;0H');
    } else {
      stdout.write('\x1B[2J\x1B[H');
    }
  }
}

