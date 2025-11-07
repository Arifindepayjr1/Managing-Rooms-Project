import "dart:convert";
import "dart:io";
import "../domain/aggregrate_root/room.dart";
import "../domain/roomRespositoryInterface.dart";
import "../domain/entities/patient.dart";
import "../domain/enums/room_type.dart";

class RoomRepositoryJson extends RoomRepository {
  final String filePath;
  List<Room> _rooms = [];

  RoomRepositoryJson(this.filePath);

  Future<void> _loadFromFile() async {
    final file = File(filePath);
    if (!file.existsSync()) {
      await file.writeAsString(jsonEncode([]));
    }

    final jsonString = await file.readAsString();
    final jsonList = jsonDecode(jsonString) as List;
    _rooms = jsonList.map((r) => Room.fromJson(r)).toList();
  } // AI Generated

  Future<void> _saveToFile() async {
    final file = File(filePath);
    final jsonList = _rooms.map((r) => r.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList), flush: true);
  } // AI Generated

  @override
  Future<List<Room>> getAllRoom() async {
    await _loadFromFile();
    return _rooms;
  }

  @override
  Future<List<Patient>> getAllPatient() async{
    await _loadFromFile();
    List<Patient> patients = [];
    if (_rooms.isEmpty) {
      throw Exception("Rooms is empty No Patient");
    } else {
      for (var room in _rooms) {
        for (var bed in room.getBeds) {
          if (!bed.isBedAvailable()) {
            patients.add(bed.getPatient!);
          }
        }
      }
    }
    return patients;
  }

  @override 
  Future<Patient> getPatientById(String id) async{
    List<Patient> patients = await getAllPatient();
    Patient patient = patients.firstWhere((e) => e.getId == id , orElse: () => throw Exception("No Patient Found"),);
    return patient;
  }

  @override  
  Future<List<Room>> getAllRoomByType(RoomType roomtype) async{
    List<Room> rooms = await getAllRoom();
    List<Room> typeRooms = rooms.where((e) => e.getRoomType == roomtype).toList();
    return typeRooms;
  }

  @override
  Future<void> save(Room room) async {
    await _loadFromFile();
    final index = _rooms.indexWhere((r) => r.getId == room.getId);
    if (index >= 0) {
      _rooms[index] = room;
    } else {
      _rooms.add(room);
    }
    await _saveToFile();
  } // AI generated
}
