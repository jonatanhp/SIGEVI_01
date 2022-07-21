import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sigevi_1/models/project.dart';
import 'package:sigevi_1/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class ProjectRepository{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  
  Future<String> addProject(String ciclo,String description,String ep,String profImage,String projectName,  String uid, String userName, 
   
  ) async{
    String res="Ocurrio un error al crear el projecto";
    try{
      String projectId=const Uuid().v1();
      Project project= Project(
        ciclo: ciclo,
        createdAt: DateTime.now(),
        description: description,
        ep: ep,
        profImage: profImage,
        uid: uid,
        
        
       
        
         
        projectName: projectName,
        userName: userName,
        
        
        projectId: projectId,
      );
      _firestore.collection('projects').doc(projectId).set(project.toJson());
      res="success";
      
    }catch (e) {
        print(e);
      }
    return res;
  }

  //update project

  Future<String> updateProject(String projectId, String projectName, String description, String uid, 
  String userName, String profImage, String ep, String ciclo) async{
    String res="Ocurrio un error al actualizar el projecto";
    try{
      Project project= Project(
        description: description,
        uid: uid,
        userName: userName,
        projectName: projectName,
        projectId: projectId,
        ep: ep,
        ciclo: ciclo,
        createdAt: DateTime.now(),
        profImage: profImage,
      );
      _firestore.collection('projects').doc(projectId).update(project.toJson());
      res="success";
      
    }catch (e) {
        print(e);
      }
    return res;

  }

  Future<String> deleteProject(String projectId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('projects').doc(projectId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  
} 