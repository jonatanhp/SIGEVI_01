import 'package:cloud_firestore/cloud_firestore.dart';

class Assigned{
  String description;
  String uid;
  String userName;
  String projectName;
  List attendances;
  String projectId;
  String assignedId;
  DateTime createdAt;
  //DateTime updatedAt;
  

  Assigned({
    required this.description,
    required this.uid,
    required this.userName,
    required this.projectName,
    required this.attendances,
    required this.projectId,
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
      projectName: snapshot['projectName'],
      attendances: snapshot['attendances'],
      projectId: snapshot['projectId'],
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
      'projectName': projectName,
      'attendances': attendances,
      'projectId': projectId,
      'assignedId': assignedId,
      'creatsedAt': createdAt,
      //'updatedAt': updatedAt,
      
    };
  }

  //toString method
  @override
  String toString() {
    return 'Assigned{description: $description, uid: $uid, userName: $userName, projectName: $projectName , attendances: $attendances, projectId: $projectId, createdAt: $createdAt}';
  }


}