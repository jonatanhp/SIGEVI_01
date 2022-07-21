import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sigevi_1/utils/colors.dart';
import 'package:sigevi_1/utils/global_variable.dart';
import 'package:sigevi_1/widgets/project_card.dart';
import 'package:sigevi_1/widgets/project_card_alumno.dart';

class AlumnoMainScreen extends StatefulWidget {
  const AlumnoMainScreen({Key? key}) : super(key: key);

  @override
  State<AlumnoMainScreen> createState() => _AlumnoMainScreenState();
}

class _AlumnoMainScreenState extends State<AlumnoMainScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              title: SvgPicture.asset(
                'assets/logooo.svg',
                color: primaryColor,
                height: 32,
              ),
              /*actions: [
                IconButton(
                  icon: const Icon(
                    Icons.messenger_outline,
                    color: primaryColor,
                  ),
                  onPressed: () {},
                ),
              ],*/
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('projects').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreenSize ? width * 0.3 : 0,
                vertical: width > webScreenSize ? 15 : 0,
              ),
              child: ProjectCardAlumno(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}
