import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sigevi_1/ui/pages/alumno/alumno_main_screen.dart';
import 'package:sigevi_1/ui/pages/alumno/alumno_profile_screen.dart';
import 'package:sigevi_1/ui/pages/profile_screen.dart';
import 'package:sigevi_1/ui/projectbloc/add_project_screen.dart';
import 'package:sigevi_1/ui/pages/main_screen.dart';

import '../ui/pages/attendancebloc/add_attendance_screen.dart';


const webScreenSize = 600;

List<Widget> homeAlumnoScreenItems = [

  const AlumnoMainScreen(),
  //AddAttendanceScreen(sesionId: "8fd0f310-0868-11ed-bd1e-a339e62a42e4"),
  
  AlumnoProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
  
  ];

List<Widget> homeCoordScreenItems = [

  const MainScreen(),
  const Text('notifications'),
  const AddProjectScreen(),
  
    
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
  
  
];


