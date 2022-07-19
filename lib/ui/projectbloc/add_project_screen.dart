import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sigevi_1/providers/user_provider.dart';
//import 'package:sigevi_1/resources/firestore_methods.dart';
import 'package:sigevi_1/utils/colors.dart';
import 'package:sigevi_1/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:sigevi_1/repository/proyectRepository.dart';
import 'package:sigevi_1/models/user.dart' as model;

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen>{
  bool isLoading=false;
  final TextEditingController _projectNameController=TextEditingController();
  final TextEditingController _descriptionController=TextEditingController();

  void postProject(String uid, String userName, String profImage)async{
    setState(() {
      isLoading=true;
    });
    try{
      String res=await ProyectRepository().addProject(
        _projectNameController.text, 
        _descriptionController.text, 
        uid, 
        userName, 
        profImage,
        );
      if(res=="Proyecto creado correctamente"){
        setState(() {
          isLoading=false;
        });
        showSnackBar(context, '¡Proyecto Creado!',);

        }else{
          showSnackBar(context, res);
        }
    }catch(e){
      setState(() {
        isLoading=false;
      });
      showSnackBar(context, 'Ocurrio un error al crear el proyecto',);
     
    }
    }

  @override
  void dispose() {
    super.dispose();
    _projectNameController.dispose();
    _descriptionController.dispose();
    

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
        title: Text('Crear Proyecto', style: TextStyle(color: Colors.white),),
        centerTitle: false,
        actions: <Widget>[
          TextButton(
            onPressed: ()=> postProject(
              userProvider.getUser.uid, 
              userProvider.getUser.userName, 
              userProvider.getUser.photoUrl
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
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(userProvider.getUser.photoUrl),
                radius: 30,
              
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.3,
                child: TextField(
                  controller: _projectNameController,
                  decoration: const InputDecoration(
                    hintText: 'Nombre del Proyecto',
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
