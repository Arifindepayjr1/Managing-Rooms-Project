import "../entities/bed.dart";
import "../entities/patient.dart";
import "../enums/room_type.dart";
class Room{
  final String _id;
  RoomType _roomType;
  List<Bed> _beds;

  Room({required String id, required RoomType roomType , required List<Bed> beds}) : 
  _id = id , _roomType = roomType, _beds = beds;


  RoomType get getRoomType => _roomType;
  String get getId => _id;
  List<Bed> get getBeds => _beds;


  List<Bed> getAvailableBed(){
    List<Bed> b = _beds.where((b) => b.isBedAvailable()).toList();
    return b;
  } 

  void assignPatientToAvailableBed(Patient patient){
    try{
      Bed? b = _beds.firstWhere((b) => b.isBedAvailable());
      b.assignPatient(patient);
    }catch(error){
      print("No Bed Available");
    }
  }


  void releasePatientFromBed(Patient patient) {
     Bed? foundBed;
    try{
     foundBed = _beds.firstWhere(
        (b) => b.getPatient != null && b.getPatient!.getId == patient.getId,
        orElse: () => throw Exception("Patient Cant Be Found"),
      );
    }catch(error){
      return;
    }

    foundBed.releasePatient();
    print("Patient ${patient.getUserName} discharged from room $_id");
  }


  bool isFull(){
    bool isFull = _beds.every((b) => !b.isBedAvailable());
    return isFull;
  }

  @override
  String toString(){
    return """
          RoomId: $_id,
          RoomType: $_roomType,
          Bed: $_beds
    """;
  }

  Map<String, dynamic> toJson() => {
    'id': _id,
    'roomType': _roomType.name,
    'beds': _beds.map((b) => b.toJson()).toList(),
  };

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    id: json['id'],
    roomType: RoomType.values.firstWhere((e) => e.name == json['roomType']),
    beds: (json['beds'] as List).map((b) => Bed.fromJson(b)).toList(),
  );
}