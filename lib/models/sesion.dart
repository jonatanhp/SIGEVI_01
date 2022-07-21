import 'package:cloud_firestore/cloud_firestore.dart';

class Sesion{
  String projectId;
  String projectName;
  String uid;
  String userName;
  String sesionId;
  String description;
  DateTime createdAt;


  Sesion({
    required this.projectId,
    required this.projectName,
    required this.uid,
    required this.userName,
    required this.sesionId,
    required this.description,
    required this.createdAt,
  });

  static Sesion fromSnapshot(DocumentSnapshot snapshot) {
    var snap=snapshot.data();
    return Sesion(
      projectId: snapshot['projectId'],
      projectName: snapshot['projectName'],
      uid: snapshot['uid'],
      userName: snapshot['userName'],
      sesionId: snapshot['sesionId'],
      description: snapshot['description'],
      createdAt: snapshot['createdAt'],
    );
  }

  //toJson method
  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'projectName': projectName,
      'uid': uid,
      'userName': userName,
      'sesionId': sesionId,
      'description': description,
      'createdAt': createdAt,
    };
  }

  //toString method
  @override
  String toString() {
    return 'Sesion{projectId: $projectId, projectName: $projectName, sesionId: $sesionId, description: $description, createdAt: $createdAt}';
  }
}