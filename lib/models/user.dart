import "package:cloud_firestore/cloud_firestore.dart";

class User {
  final String uid;
  final String userName;
  final String email;
  final String photoUrl;
  final String ep;
  final String ciclo;
  
  

  User({
    required this.uid,
    required this.userName,
    required this.email,
    required this.photoUrl,
    required this.ep,
    required this.ciclo,
    
    
  });

  static User fromSnapshot(DocumentSnapshot snap) {
    var snapshot=snap.data() as Map<String, dynamic>; 
    return User(
      uid: snapshot['uid'],
      userName: snapshot['userName'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      ep: snapshot['ep'],
      ciclo: snapshot['ciclo'], 
      
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userName': userName,
      'email': email,
      'photoUrl': photoUrl,
      'ep': ep,
      'ciclo': ciclo,
      
      
    };
  }

  // ignore: avoid_types_as_parameter_names
  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      uid: json['uid'],
      userName: json['userName'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      ep: json['ep'],
      ciclo: json['ciclo'],
      
      
    );
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['uid'] = uid;
    map['userName'] = userName;
    map['email'] = email;
    map['photoUrl'] = photoUrl;
    map['ep'] = ep;
    map['ciclo'] = ciclo;

    
    return map;
  }

  /*User.fromObject(dynamic o)
  {
    this.uid = o["uid"];
    this.userName = o["userName"];
    this.email = o["email"];
    this.photoUrl = o["photoUrl"];
    this.ep = o["ep"];
    
    this.proyects = o["proyects"];
    this.role = o["role"];
  }*/

  //toString method to stringify the class object
  @override
  String toString() {
    return 'User{uid: $uid, userName: $userName, email: $email, photoUrl: $photoUrl, ep: $ep}';
  }

}