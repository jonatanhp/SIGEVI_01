import 'package:cloud_firestore/cloud_firestore.dart';

class Sesion{
  String proyectId;
  String proyectName;
  String sesionId;
  String description;
  DateTime createdAt;

  Sesion({
    required this.proyectId,
    required this.proyectName,
    required this.sesionId,
    required this.description,
    required this.createdAt,
  });

  static Sesion fromSnapshot(DocumentSnapshot snapshot) {
    var snap=snapshot.data();
    return Sesion(
      proyectId: snapshot['proyectId'],
      proyectName: snapshot['proyectName'],
      sesionId: snapshot['sesionId'],
      description: snapshot['description'],
      createdAt: snapshot['createdAt'],
    );
  }

  //toJson method
  Map<String, dynamic> toJson() {
    return {
      'proyectId': proyectId,
      'proyectName': proyectName,
      'sesionId': sesionId,
      'description': description,
      'createdAt': createdAt,
    };
  }

  //toString method
  @override
  String toString() {
    return 'Sesion{proyectId: $proyectId, proyectName: $proyectName, sesionId: $sesionId, description: $description, createdAt: $createdAt}';
  }
}