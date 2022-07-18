import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sigevi_1/models/proyect.dart';
import 'package:sigevi_1/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class ProyectRepository{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  
  Future<String> addProject(String projectName, String description, String uid, String userName, String profImage) async{
    String res="Ocurrio un error al crear el proyecto";
    try{
      String projectId=const Uuid().v4();
      Proyect project= Proyect(
        description: description,
        uid: uid,
        userName: userName,
        proyectName: projectName,
        attendances: [],
        proyectId: projectId,
        createdAt: DateTime.now(),
        profImage: profImage,
      );
      _firestore.collection('proyects').doc(projectId).set(project.toJson());
      res="Proyecto creado correctamente";
      
    }catch (e) {
        print(e);
      }
    return res;
  }

  //update project

  Future<String> updateProject(String projectId, String projectName, String description, String uid, String userName, String profImage) async{
    String res="Ocurrio un error al actualizar el proyecto";
    try{
      Proyect project= Proyect(
        description: description,
        uid: uid,
        userName: userName,
        proyectName: projectName,
        attendances: [],
        proyectId: projectId,
        createdAt: DateTime.now(),
        profImage: profImage,
      );
      _firestore.collection('proyects').doc(projectId).update(project.toJson());
      res="Proyecto actualizado correctamente";
      
    }catch (e) {
        print(e);
      }
    return res;
  }

  
} 