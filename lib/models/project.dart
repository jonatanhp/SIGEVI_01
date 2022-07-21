import 'package:cloud_firestore/cloud_firestore.dart';

class Project{
  String description;
  String uid;
  String userName;
  String projectName;
  String ep;
  String ciclo;
  String projectId;
  DateTime createdAt;
  //DateTime updatedAt;
  String profImage;

  Project({
    required this.description,
    required this.uid,
    required this.userName,
    required this.projectName,
    required this.ep,
    required this.ciclo,
    required this.projectId,
    required this.createdAt,
    //required this.updatedAt,
    required this.profImage,
  });

  static Project fromSnapshot(DocumentSnapshot snapshot) {
    var snap=snapshot.data();
    return Project(
      description: snapshot['description'],
      uid: snapshot['uid'],
      userName: snapshot['userName'],
      projectName: snapshot['projectName'],
      ep: snapshot['ep'],
      ciclo: snapshot['ciclo'],
      projectId: snapshot['projectId'],
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
      'projectName': projectName,
      'ep': ep,
      'ciclo': ciclo,
      'projectId': projectId,
      'creatsedAt': createdAt,
      //'updatedAt': updatedAt,
      'profImage': profImage,
    };
  }

  //toString method
  @override
  String toString() {
    return 'Project{description: $description, uid: $uid, userName: $userName, projectName: $projectName, ep: $ep, ciclo: $ciclo, projectId: $projectId, createdAt: $createdAt, profImage: $profImage}';
  }


}