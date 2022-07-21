import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sigevi_1/models/attendance.dart';
import 'package:sigevi_1/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class AttendanceRepository{

  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  Future<String> addAttendance( String uid, String sesionId, 
   String userName  , Uint8List file) async{
    String res="Ocurrio un error al inscribirse al proyecto";
    try{

      String photoUrl =
          await StorageMethods().uploadImageToStorage('attendances', file, true);
      String attendanceId=const Uuid().v1();
      Attendance attendance= Attendance(
       
        uid: uid,
        userName: userName,
        //proyectId: proyectId,
        //proyectName: projectName,
        sesionId: sesionId,
        attendanceId: attendanceId,
        photoUrl: photoUrl,
        
        
        createdAt: DateTime.now(),
        
      );
      _firestore.collection('attendances').doc(attendanceId).set(attendance.toJson());
      res="success";
      
    }catch (e) {
        print(e);
      }
    return res;
  }
}