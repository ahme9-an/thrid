import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/user_model.dart';

class UserViewModel {
  final _userDB = FirebaseFirestore.instance.collection('User');
  final ref = firebase_storage.FirebaseStorage.instance.ref("usersImages/");

  Stream<List<UserModel>> getUserByPhoneNumber(String phoneNumber) {
    print("hiiiiiiiiiiiiii iiiiiiiiiiii ddddddddddd");
    return _userDB
        .where('primaryPhoneNo', isEqualTo: phoneNumber)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => UserModel.fromJson(doc.data(), doc.id))
            .toList());
  }

  Future<String> addUser(UserModel entity) async {
    try {
      String documnentid = "";
      await _userDB
          .add(entity.toJson())
          .then((value) => documnentid = value.id);
      print("hhhhhhhhhhhsssssssssssssssssss");
      // _batchWriter!.set(_userDB.doc(), entity.toJson());
      // final fileName = basename(entity.filePath!.path);
      final destination = documnentid;
      try {
        await ref.child(destination).putFile(entity.filePhotoPath!);
      } catch (e) {
        print('error occured');
      }

      return documnentid;
    } catch (e) {
      print(e.toString());
    }
    return "true";
  }

  Future<UserModel> getUserById(String id) async {
    final result = await _userDB.doc(id).get();
    if (result.exists) {
      return UserModel.fromJson(result.data()!, id);
    }
    return null!;
  }

  Stream<List<UserModel>> getAllUsers() {
    return _userDB.snapshots(includeMetadataChanges: true).map((snapshot) =>
        snapshot.docs
            .map((doc) => UserModel.fromJson(doc.data(), doc.id))
            .toList());
  }

  Stream<List<UserModel>> getByMajor(String major) {
    print("hiiiiiiiiiiiiii iiiiiiiiiiii ddddddddddd");
    return _userDB
        .where('major', isEqualTo: major)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => UserModel.fromJson(doc.data(), doc.id))
            .toList());
  }

  Stream<List<UserModel>> getByMajorandQualification(
      String major, String qualification) {
    print("hiiiiiiiiiiiiii iiiiiiiiiiii ddddddddddd");
    return _userDB
        .where('major', isEqualTo: major)
        .where('qualification', isEqualTo: qualification)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => UserModel.fromJson(doc.data(), doc.id))
            .toList());
  }

  Future<bool> updateUser(UserModel entity) async {
    entity.views = 0;
    try {
      _userDB.doc(entity.id).update({
        "name": entity.name,
        "major": entity..major,
        "qualification": entity.qualification,
        "views": entity.views,
      });
      return true;
    } catch (e) {
      print("eeeeeeeeeeeeeeeeeeeee${e.toString()}");
      return false;
    }
  }
}
