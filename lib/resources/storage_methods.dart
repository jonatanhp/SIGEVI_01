import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  
  Future<String> uploadImageToStorage(String childName, Uint8List file, bool isAttendan) async{

    Reference ref=
          _storage.ref().child(childName).child(_auth.currentUser!.uid);
      if (isAttendan) {
        String id=const Uuid().v4();
        ref = ref.child(id);
      }

      UploadTask uploadTask = ref.putData(file);

      TaskSnapshot storageTaskSnapshot = await uploadTask;
      String url = await storageTaskSnapshot.ref.getDownloadURL();
      return url;
  }
}