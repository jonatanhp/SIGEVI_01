import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sigevi_1/models/user.dart' as model;
import 'package:sigevi_1/providers/user_provider.dart';
import 'package:sigevi_1/repository/assignedRepository.dart';
import 'package:sigevi_1/resources/firestore_methods.dart';
import 'package:sigevi_1/repository/proyectRepository.dart';
import 'package:sigevi_1/ui/pages/alumno/alumno_sesion_screen.dart';
import 'package:sigevi_1/ui/sesionbloc/add_sesion_screen.dart';
//import 'package:sigevi_1/screens/comments_screen.dart';
import 'package:sigevi_1/utils/colors.dart';
import 'package:sigevi_1/utils/global_variable.dart';
import 'package:sigevi_1/utils/utils.dart';
//import 'package:sigevi_1/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProjectCardAlumno extends StatefulWidget {
  final snap;
  const ProjectCardAlumno({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<ProjectCardAlumno> createState() => _ProjectCardAlumnoState();
}

class _ProjectCardAlumnoState extends State<ProjectCardAlumno> {
  //int commentLen = 0;
  bool isLikeAnimating = false;

  @override
  void initState() {
    super.initState();
    fetchCommentLen();
  }

  

  fetchCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('projects')
          
          .get();
      //commentLen = snap.docs.length;
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
    
  }

  deleteProject(String postId) async {
    try {
      await ProyectRepository().deleteProject(postId);
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;

    return Container(
      // boundary needed for web
      decoration: BoxDecoration(
        border: Border.all(
          color: width > webScreenSize ? secondaryColor : mobileBackgroundColor,
        ),
        color: mobileBackgroundColor,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          // HEADER SECTION OF THE POST
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    widget.snap['profImage'].toString(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.snap['userName'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                widget.snap['uid'].toString() == user.uid
                    ?

                    IconButton(
                                  icon: Icon(Icons.list),
                                  onPressed: () {
                                    //invoque AlumnoSesionScreen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AlumnoSesionScreen(
                                          proyectId: widget.snap['proyectId'].toString(),
                                        ),
                                      ),
                                    );
                                    child: AlumnoSesionScreen( proyectId:widget.snap['proyectId']);
                                  }): Container(),

                    IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    AssignedRepository().addAssigned(widget.snap['proyectName'],widget.snap['proyectId'],widget.snap['uid'],widget.snap['userName'],"ddd");
                                    //disable Icon Button
                                    showSnackBar(context, '¡Registrado en el proyecto!',);
                                    setState(() {
                                      isLikeAnimating = true;
                                      Icons.disabled_by_default;
                                    });
                                  }),
                    
                    IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                Text("Mensaje de confirmacion"),
                                            content: Text("Desea Eliminar?"),
                                            actions: [
                                              FlatButton(
                                                child: const Text('CANCEL'),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop('Failure');
                                                },
                                              ),
                                              FlatButton(
                                                  child: const Text('ACCEPT'),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop('Success');
                                                  })
                                            ],
                                          );
                                        }).then((value) {
                                      /*if (value.toString() == "Success") {
                                        print(beneficiariox.id);
                                        /*Provider.of<BeneficiarioApi>(context,
                                                listen: false)
                                            .deleteBeneficiario(beneficiariox.id)
                                            .then((value) => onGoBack(value));*/
                                        //var onGoBack = onGoBack;
                                        BlocProvider.of<BeneficiarioBloc>(context).add(DeleteBeneficiarioEvent(beneficiario: beneficiariox));
                                      }*/
                                    });
                                  })
                    
              ],
            ),
          ),
          // IMAGE SECTION OF THE POST
          /*GestureDetector(
            onDoubleTap: () {
              ProyectRepository().likePost(
                widget.snap['postId'].toString(),
                user.uid,
                widget.snap['likes'],
              );
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(
                    widget.snap['postUrl'].toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    isAnimating: isLikeAnimating,
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 100,
                    ),
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),*/
          // LIKE, COMMENT SECTION OF THE POST
          /*Row(
            children: <Widget>[
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
                smallLike: true,
                child: IconButton(
                  icon: widget.snap['likes'].contains(user.uid)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border,
                        ),
                  onPressed: () => ProyectRepository().likePost(
                    widget.snap['postId'].toString(),
                    user.uid,
                    widget.snap['likes'],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.comment_outlined,
                ),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommentsScreen(
                      postId: widget.snap['postId'].toString(),
                    ),
                  ),
                ),
              ),
              IconButton(
                  icon: const Icon(
                    Icons.send,
                  ),
                  onPressed: () {}),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    icon: const Icon(Icons.bookmark_border), onPressed: () {}),
              ))
            ],
          ),*/
          //DESCRIPTION AND NUMBER OF COMMENTS
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: widget.snap['userName'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' ${widget.snap['description']}',
                        ),
                      ],
                    ),
                  ),
                ),
                /*InkWell(
                  child: Container(
                    child: Text(
                      'View all $commentLen comments',
                      style: const TextStyle(
                        fontSize: 16,
                        color: secondaryColor,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 4),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CommentsScreen(
                        postId: widget.snap['postId'].toString(),
                      ),
                    ),
                  ),
                ),*/

                Container(
                  child: Text(
                    (widget.snap['proyectName']),
                    style: const TextStyle(
                      color: secondaryColor,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                ),

                Container(
                  child: Text(
                    DateFormat.yMMMd()
                        .format(widget.snap['creatsedAt'].toDate()),
                    style: const TextStyle(
                      color: secondaryColor,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
