import 'package:room_managing/domain/entities/patient.dart';
import 'package:nanoid/nanoid.dart';
import 'package:test/test.dart';
import 'package:room_managing/domain/enums/gender.dart';
import 'package:room_managing/domain/enums/room_type.dart';
import "package:room_managing/data/roomRespository.dart";
import "package:room_managing/domain/services/admissionService.dart";
import "package:room_managing/domain/roomRespositoryInterface.dart";
final RoomRepository roomRepository = RoomRepositoryJson("rooms1.json");
void main(){
  Admissionservice admissionService = Admissionservice(roomRepository);


  Patient patient = Patient(
    id: nanoid(8),
    name: "John Doe",
    age: 30,
    gender: Gender.male,
    currentCondition: "Dry Cough",
  );

  Patient patient1 = Patient(
    id: nanoid(8),
    name: "Kanzaki",
    age: 20,
    gender: Gender.male,
    currentCondition: "Dry Cough",
  );

   Patient patient2 = Patient(
    id: nanoid(8),
    name: "arifindepayjr",
    age: 20,
    gender: Gender.male,
    currentCondition: "Dry Cough",
  );

  test("Should admit patient", () async {

    await admissionService.admitPatient(patient , RoomType.icu);
    Patient otherPatient = await admissionService.viewPatientById(patient.getId);
    expect(otherPatient.getId, patient.getId);
  });

  test("Patient should be discharged" , () async{
    await admissionService.admitPatient(patient1, RoomType.general);
    await admissionService.dischargedPatient(patient1);
    try{
      await admissionService.viewPatientById(patient1.getId);
    }catch(e){
      expect(e.toString(), contains("No Patient Found"));
    }
  });

  test("View Patient By Id" , () async{
    await admissionService.admitPatient(patient2, RoomType.isolation);
    Patient fetchedPatient = await admissionService.viewPatientById(patient2.getId);

    expect(fetchedPatient.getId , patient2.getId);
  });


  
}