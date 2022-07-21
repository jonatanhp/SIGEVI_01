import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sigevi_1/providers/user_provider.dart';
//import 'package:sigevi_1/resources/firestore_methods.dart';
import 'package:sigevi_1/utils/colors.dart';
import 'package:sigevi_1/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:sigevi_1/repository/projectRepository.dart';
import 'package:sigevi_1/repository/sesionRepository.dart';
import 'package:sigevi_1/models/user.dart' as model;

class AddSesionScreen extends StatefulWidget {
  final String uid;
  final String projectId;
  
  
  const AddSesionScreen({Key? key, required this.uid, required this.projectId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddSesionScreenState createState() => _AddSesionScreenState();
}

class _AddSesionScreenState extends State<AddSesionScreen>{
  int projectsLen=0;
  var userData = {};
  var projectData = {};
  bool isLoading=false;
  //final TextEditingController _projectNameController=TextEditingController();
  final TextEditingController _descriptionController=TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: widget.uid)
          .get();

      // get post lENGTH
      var postSnap = await FirebaseFirestore.instance
          .collection('projects')
          .where('projectId', isEqualTo: widget.projectId)
          .get();

      projectsLen = postSnap.docs.length;
      userData = userSnap.docs[0].data();
      projectData = postSnap.docs[0].data();
      
      
      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  void postSesion(String uid, String userName, String projectId, String projectName,
  String description)async{
    setState(() {
      isLoading=true;
    });
    try{
      String res=await SesionRepository().addSesion(
        projectName, 
        projectId, 
        uid, 
        userName, 
        description,
        );
        
      if(res=="success"){
        setState(() {
          isLoading=false;
        });
        showSnackBar(context, '¡Sesión añadida!',);

        }else{
          showSnackBar(context, res);
        }
    }catch(e){
      setState(() {
        isLoading=false;
      });
      showSnackBar(context, 'Ocurrio un error al crear el projecto',);
     
    }
    }

  @override
  void dispose() {
    super.dispose();
    
    

  }
  @override
  Widget build(BuildContext context){
    final UserProvider userProvider=Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('Añadir sesión', style: TextStyle(color: Colors.white),),
        centerTitle: false,
        actions: <Widget>[
          TextButton(
            onPressed: ()=> postSesion(
              userData['uid'],
              userData['userName'],
              projectData['projectId'],
              projectData['projectName'],
              _descriptionController.text,
              ),
              child: const Text(
                "Crear",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                
              )
            
          )
        ],
      ),


      //create project form
      body:Column(
        children:<Widget>[
          const SizedBox(
                height: 14,
              ),
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(userProvider.getUser.photoUrl),
                radius: 30,
              
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.8,
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Descripción de la sesion', 
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ]
          )
        ]
      )
    );
    }
        

  

}
