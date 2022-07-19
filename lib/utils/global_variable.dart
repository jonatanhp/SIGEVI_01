import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sigevi_1/ui/projectbloc/add_project_screen.dart';
import 'package:sigevi_1/ui/pages/main_screen.dart';


const webScreenSize = 600;

List<Widget> homeScreenItems = [

  const MainScreen(),
  const Text('notifications'),
  const AddProjectScreen(),
  
  
];
