import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cvmaker/models/profile_model.dart';

class ProfileViewModel {
  final _profileDB = FirebaseFirestore.instance.collection('Profile');

  Future<String> addProfile(ProfileModel entity) async {
    print("kkkkkkkkkkk");
    try {
      String documnentid = "";
      entity.id == "non"
          ? await _profileDB.doc().set(entity.toJson())
          : await _profileDB.doc(entity.id).set(entity.toJson());
      return documnentid;
    } catch (e) {
      print(e.toString());
    }
    return "true";
  }

  Stream<List<ProfileModel>> getAllMajors() {
    return _profileDB.snapshots(includeMetadataChanges: true).map((snapshot) =>
        snapshot.docs
            .map((doc) => ProfileModel.fromJson(doc.data(), doc.id))
            .toList());
  }

  Future<bool> deleteProfile(ProfileModel entity) async {
    try {
      _profileDB.doc(entity.id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<List<ProfileModel>> getProfileByUserId(String userID) {
    print("hiiiiiiiiiiiiii iiiiiiiiiiii ddddddddddd");
    return _profileDB
        .where('userID', isEqualTo: userID)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => ProfileModel.fromJson(doc.data(), doc.id))
            .toList());
  }
}
