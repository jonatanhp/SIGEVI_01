import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance{
  String uid;
  String userName;
  String proyectId;
  String proyectName;
  String sesionId;
  String attendanceId;
  DateTime createdAt;
  String photoUrl;

  Attendance({
    required this.uid,
    required this.userName,
    required this.proyectId,
    required this.proyectName,
    required this.sesionId,
    required this.attendanceId,
    required this.createdAt,
    required this.photoUrl,
  });

  static Attendance fromSnapshot(DocumentSnapshot snapshot) {
    var snap=snapshot.data();
    return Attendance(
      uid: snapshot['uid'],
      userName: snapshot['userName'],
      proyectId: snapshot['proyectId'],
      proyectName: snapshot['proyectName'],
      sesionId: snapshot['sesionId'],
      attendanceId: snapshot['attendanceId'],
      createdAt: snapshot['createdAt'],
      photoUrl: snapshot['photoUrl'],
    );
  }

  //toJson method
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userName': userName,
      'proyectId': proyectId,
      'proyectName': proyectName,
      'sesionId': sesionId,
      'attendanceId': attendanceId,
      'createdAt': createdAt,
      'photoUrl': photoUrl,
    };
  }

  //toString method
  @override
  String toString() {
    return 'Attendance{uid: $uid, userName: $userName, proyectId: $proyectId, proyectName: $proyectName, sesionId: $sesionId, attendanceId: $attendanceId, createdAt: $createdAt, photoUrl: $photoUrl}';
  }
  
}