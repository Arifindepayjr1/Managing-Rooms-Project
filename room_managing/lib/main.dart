import "./data/roomRespository.dart";
import 'package:room_managing/domain/services/admissionService.dart';
import 'package:room_managing/ui/roomConsole.dart';

void main() {
 final roomRepository = RoomRepositoryJson(
    "room_managing/rooms1.json",
  );
  final admissionService = Admissionservice(roomRepository);
  final console = RoomConsole(admissionservice: admissionService);

  console.start();
}
