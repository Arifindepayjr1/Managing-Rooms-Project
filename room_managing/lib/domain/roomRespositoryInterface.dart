import "package:room_managing/domain/entities/patient.dart";
import "./enums/room_type.dart";
import "../domain/aggregrate_root/room.dart";
abstract class RoomRepository {
  Future<List<Room>> getAllRoom();
  Future<List<Room>> getAllRoomByType(RoomType roomtype);
  Future<List<Patient>> getAllPatient();
  Future<Patient> getPatientById(String id);
  Future<void> save(Room room);
}
