import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sigevi_1/models/proyect.dart';
import 'package:sigevi_1/models/sesion.dart';
import 'package:sigevi_1/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class SesionRepository{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  
  Future<String> addSesion(String projectName, String proyectId, String uid, String userName  , String description) async{
    String res="Ocurrio un error al crear el proyecto";
    try{
      String sesionId=const Uuid().v1();
      Sesion sesion= Sesion(
        description: description,
        uid: uid,
        userName: userName,
        proyectId: proyectId,
        proyectName: projectName,
        sesionId: sesionId,
        
        createdAt: DateTime.now(),
        
      );
      _firestore.collection('sesions').doc(sesionId).set(sesion.toJson());
      res="success";
      
    }catch (e) {
        print(e);
      }
    return res;
  }

  //update project

  Future<String> updateSesion(String proyectId, String projectName, String description, String uid, String userName, String sesionId) async{
    String res="Ocurrio un error al actualizar el proyecto";
    try{
      Sesion sesion= Sesion(
        description: description,
        uid: uid,
        userName: userName,
        proyectId: proyectId,
        proyectName: projectName,
        sesionId: sesionId,
        
        createdAt: DateTime.now(),
        
      );
      _firestore.collection('sesions').doc(sesionId).update(sesion.toJson());
      res="success";
      
    }catch (e) {
        print(e);
      }
    return res;

  }

  Future<String> deleteSesion(String sesionId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('sesions').doc(sesionId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  
} 