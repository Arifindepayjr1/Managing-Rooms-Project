import "../entities/patient.dart";
import "../aggregrate_root/room.dart";
import "../roomRespositoryInterface.dart";
import "../enums/room_type.dart";

class Admissionservice {
  final RoomRepository roomRepository;

  Admissionservice(this.roomRepository);


  Future<Room?> findRoomForPatient(RoomType roomType) async {
    final rooms = await roomRepository.getAllRoomByType(roomType);
    try {
      return rooms.firstWhere((r) => !r.isFull());
    } catch (e) {
      return null;
    }
  }


  Future<void> admitPatient(Patient patient , RoomType roomtype) async {
    Room? room = await findRoomForPatient(roomtype);

    if (room == null) {
      throw Exception("No available beds in any room for this type of room");
    }

    patient.admitToRoom(room.getId);
    room.assignPatientToAvailableBed(patient);
    await roomRepository.save(room);
  }


  Future<void> dischargedPatient(Patient patient) async {
    final rooms = await roomRepository.getAllRoom();

    bool discharged = false;

    for (var room in rooms) {
      final before = room.getBeds.where((b) => !b.isBedAvailable()).length;
      room.releasePatientFromBed(patient);
      final after = room.getBeds.where((b) => !b.isBedAvailable()).length;

      
      if (after < before) {
        await roomRepository.save(room);
        discharged = true;
        break;
      }
    }

    if (!discharged) {
      print("Patient with ID ${patient.getId} not found in any room.");
    }
  }


  Future<List<Patient>> viewAllPatientOccupy() async{
    List<Patient> patients;
    patients = await roomRepository.getAllPatient();
    if(patients.isEmpty){
      throw Exception("No Patients Occupy");
    }
    return patients;
  }

  Future<Patient> viewPatientById(String id) async{
    final patient = await roomRepository.getPatientById(id);
    return patient;
  }

  Future<List<Room>> viewRoomByType(RoomType roomType) async{
    List<Room> rooms = await roomRepository.getAllRoomByType(roomType);
    return rooms;
  }


  Future<List<Room>> viewAllRoom() async {
    var rooms = await roomRepository.getAllRoom();
    if (rooms.isEmpty) {
      throw Exception("Room is empty");
    } else {
      return rooms;
    }
  }
}
