import 'package:cloud_firestore/cloud_firestore.dart';

class Proyect{
  String description;
  String uid;
  String userName;
  String proyectName;
  List attendances;
  String proyectId;
  DateTime createdAt;
  //DateTime updatedAt;
  String profImage;

  Proyect({
    required this.description,
    required this.uid,
    required this.userName,
    required this.proyectName,
    required this.attendances,
    required this.proyectId,
    required this.createdAt,
    //required this.updatedAt,
    required this.profImage,
  });

  static Proyect fromSnapshot(DocumentSnapshot snapshot) {
    var snap=snapshot.data();
    return Proyect(
      description: snapshot['description'],
      uid: snapshot['uid'],
      userName: snapshot['userName'],
      proyectName: snapshot['proyectName'],
      attendances: snapshot['attendances'],
      proyectId: snapshot['proyectId'],
      createdAt: snapshot['createdAt'],
      //updatedAt: snapshot['updatedAt'],
      profImage: snapshot['profImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'uid': uid,
      'userName': userName,
      'proyectName': proyectName,
      'attendances': attendances,
      'proyectId': proyectId,
      'creatsedAt': createdAt,
      //'updatedAt': updatedAt,
      'profImage': profImage,
    };
  }

  //toString method
  @override
  String toString() {
    return 'Proyect{description: $description, uid: $uid, userName: $userName, proyectName: $proyectName , attendances: $attendances, proyectId: $proyectId, createdAt: $createdAt, profImage: $profImage}';
  }


}