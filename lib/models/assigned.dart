import 'package:cloud_firestore/cloud_firestore.dart';

class Assigned{
  String description;
  String uid;
  String userName;
  String proyectName;
  List attendances;
  String proyectId;
  String assignedId;
  DateTime createdAt;
  //DateTime updatedAt;
  

  Assigned({
    required this.description,
    required this.uid,
    required this.userName,
    required this.proyectName,
    required this.attendances,
    required this.proyectId,
    required this.assignedId,
    required this.createdAt,
    //required this.updatedAt,
    
  });

  static Assigned fromSnapshot(DocumentSnapshot snapshot) {
    var snap=snapshot.data();
    return Assigned(
      description: snapshot['description'],
      uid: snapshot['uid'],
      userName: snapshot['userName'],
      proyectName: snapshot['proyectName'],
      attendances: snapshot['attendances'],
      proyectId: snapshot['proyectId'],
      assignedId: snapshot['assignedId'],
      createdAt: snapshot['createdAt'],
      //updatedAt: snapshot['updatedAt'],
      
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
      'assignedId': assignedId,
      'creatsedAt': createdAt,
      //'updatedAt': updatedAt,
      
    };
  }

  //toString method
  @override
  String toString() {
    return 'Assigned{description: $description, uid: $uid, userName: $userName, proyectName: $proyectName , attendances: $attendances, proyectId: $proyectId, createdAt: $createdAt}';
  }


}