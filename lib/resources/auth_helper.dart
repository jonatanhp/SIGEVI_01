import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sigevi_1/models/user.dart' as model;
import 'package:sigevi_1/resources/storage_methods.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async{
    User currentUser=_auth.currentUser!;
    //esta ha sido probablemente la peor presentación que he tendi oen mi vida
    
    DocumentSnapshot documentSnapshot=
        await _firestore.collection('users').doc(currentUser.uid).get();
    
    return model.User.fromSnapshot(documentSnapshot);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String userName,
    required String ep,
    required String ciclo,
    required Uint8List image,

  }) async{
    String res= "Ocurrio un error al registrar el usuario";
    try{
      if(email.isNotEmpty ||
         password.isNotEmpty ||
         userName.isNotEmpty ||
         ep.isNotEmpty ||
         ciclo.isNotEmpty ||
         image != null){

          //register user with email and password
          UserCredential userCredential=
            await _auth.createUserWithEmailAndPassword(
              email: email,
              password: password
            );

          String photoUrl=await StorageMethods().uploadImageToStorage('profilePics', image,false);

          model.User user=model.User(
            uid: userCredential.user!.uid,
            userName: userName,
            email: email,
            photoUrl: photoUrl,
            ep: ep,
            ciclo: ciclo,
            
          );

          await _firestore.collection('users').doc(userCredential.user!.uid).set(user.toJson());
          res="success";
    }
    else{
      res="Todos los campos son obligatorios";
    }
  }
  catch(e){
    print(e.toString());
  }
  return res;
  }

  //logging in user with email and password

  Future<String> logInUser({
    required String email,
    required String password,
  }) async{
    String res= "Ocurrio un error al iniciar sesion";
    try{
      if(email.isNotEmpty ||
         password.isNotEmpty){

          //register user with email and password
          UserCredential userCredential=
            await _auth.signInWithEmailAndPassword(
              email: email,
              password: password
            );

          res="success";
    }
    else{
      res="Todos los campos son obligatorios";
    }
  }
  catch(e){
    print(e.toString());
  }
  return res;
  }

  //logout user
  Future<void> logOutUser() async{
    return _auth.signOut();
  }

}




  

