import "package:cloud_firestore/cloud_firestore.dart";

class User {
  final String uid;
  final String userName;
  final String email;
  final String photoUrl;
  final String ep;
  
  List proyects;
  String role;

  User({
    required this.uid,
    required this.userName,
    required this.email,
    required this.photoUrl,
    required this.ep,
    
    required this.proyects,
    required this.role,
  });

  static User fromSnapshot(DocumentSnapshot snapshot) {
    return User(
      uid: snapshot['uid'],
      userName: snapshot['userName'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      ep: snapshot['ep'],
      
      proyects: snapshot['proyects'],
      role: snapshot['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userName': userName,
      'email': email,
      'photoUrl': photoUrl,
      'ep': ep,
      
      'proyects': proyects,
      'role': role,
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
      
      proyects: json['proyects'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['uid'] = uid;
    map['userName'] = userName;
    map['email'] = email;
    map['photoUrl'] = photoUrl;
    map['ep'] = ep;

    map['proyects'] = proyects;
    map['role'] = role;
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
    return 'User{uid: $uid, userName: $userName, email: $email, photoUrl: $photoUrl, ep: $ep, proyects: $proyects, role: $role}';
  }

}