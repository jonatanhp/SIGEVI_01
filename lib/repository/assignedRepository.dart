import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sigevi_1/models/project.dart';
//import 'package:sigevi_1/models/assigned.dart';
import 'package:sigevi_1/models/assigned.dart';
import 'package:sigevi_1/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class AssignedRepository{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  
  Future<String> addAssigned(String projectName, String projectId, String uid, String userName  , String description) async{
    String res="Ocurrio un error al inscribirse al projecto";
    try{
      String assignedId=const Uuid().v1();
      Assigned assigned= Assigned(
        description: description,
        uid: uid,
        userName: userName,
        projectId: projectId,
        projectName: projectName,
        attendances: [],
        assignedId: assignedId,
        
        
        createdAt: DateTime.now(),
        
      );
      _firestore.collection('assigneds').doc(assignedId).set(assigned.toJson());
      res="success";
      
    }catch (e) {
        print(e);
      }
    return res;
  }

  //update project

  Future<String> updateAssigned(String projectId, String projectName, String description, String uid, String userName, String assignedId) async{
    String res="Ocurrio un error al actualizar el projecto";
    try{
      Assigned assigned= Assigned(
        description: description,
        uid: uid,
        userName: userName,
        projectId: projectId,
        projectName: projectName,
        attendances: [],
        assignedId: assignedId,

        
        
        createdAt: DateTime.now(),
        
      );
      _firestore.collection('assigneds').doc(assignedId).update(assigned.toJson());
      res="success";
      
    }catch (e) {
        print(e);
      }
    return res;

  }

  Future<String> deleteAssigned(String assignedId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('assigneds').doc(assignedId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  
} 