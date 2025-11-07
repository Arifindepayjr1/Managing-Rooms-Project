import 'package:room_managing/domain/entities/patient.dart';
import 'package:nanoid/nanoid.dart';
import 'package:test/test.dart';
import 'package:room_managing/domain/enums/gender.dart';
import 'package:room_managing/domain/aggregrate_root/room.dart';
import 'package:room_managing/domain/enums/bed_status.dart';
import 'package:room_managing/domain/enums/room_type.dart';
import 'package:room_managing/domain/entities/bed.dart';

void main(){

  Patient patient1 = Patient(
    name: "John Doe", 
    age: 30, 
    gender: Gender.male, 
    id: "P001", 
    roomId: "R001", 
    currentCondition: "Dry Cough",
  );

  Patient patient2 = Patient(
    name: "Jane Smith", 
    age: 25, 
    gender: Gender.female, 
    id: "P002", 
    roomId: "R002", 
    currentCondition: "Fever",
  );

  Bed bed1 = Bed(
    id: "B001",
    bedStatus: BedStatus.available,
    patient: patient1,
  );

  Bed bed2 = Bed(
    id: "B002",
    bedStatus: BedStatus.available,
    patient: patient2,
  );

  Room room = Room(
    id: nanoid(8),
    roomType: RoomType.general,
    beds: [bed1 , bed2],
  );

  test("Should assign Patient to available room" , (){
    room.assignPatientToAvailableBed(patient1);
    room.assignPatientToAvailableBed(patient2);

    expect(room.isFull() , true);
  });

  test("Should release Patient from bed" , (){
    room.releasePatientFromBed(patient1);
    expect(room.isFull(), false);
  });

  test("Should Show available beds" , (){
    List<Bed> availableBeds = room.getAvailableBed();
    expect(availableBeds.length,  1);
  });

}
