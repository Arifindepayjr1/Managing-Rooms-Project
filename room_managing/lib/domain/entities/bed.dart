import "../enums/bed_status.dart";
import "../entities/patient.dart";

class Bed {
  final String _id;
  BedStatus _bedStatus;
  Patient? _patient;

  Bed({required String id, required BedStatus bedStatus, Patient? patient})
    : _id = id,
      _bedStatus = bedStatus,
      _patient = patient;

  String get getId => _id;
  BedStatus get getBedStatus => _bedStatus;
  Patient? get getPatient => _patient;

  set setBedStatus(BedStatus newBedStatus) => _bedStatus = newBedStatus;

  bool isBedAvailable() => _bedStatus == BedStatus.available;

  void assignPatient(Patient newPatient) {
    if (_bedStatus == BedStatus.available) {
      _patient = newPatient;
      _bedStatus = BedStatus.occupied;
      return;
    }
    throw Exception("Bed is not available");
  }

  void releasePatient() {
    _patient = null;
    _bedStatus = BedStatus.available;
  }

  @override
  String toString() {
    return """
      BedId : $_id,
      BedStatus: $_bedStatus,
      Patient: $_patient,
    """;
  }

  Map<String, dynamic> toJson() => {
    'id': _id,
    'status': _bedStatus.name,
    'patient': _patient?.toJson(),
  };

  factory Bed.fromJson(Map<String, dynamic> json) => Bed(
    id: json['id'],
    bedStatus: BedStatus.values.firstWhere((e) => e.name == json['status']),
    patient: json['patient'] != null ? Patient.fromJson(json['patient']) : null,
  );
}
