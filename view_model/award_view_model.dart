import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cvmaker/models/award_model.dart';

class AwardViewModel {
  final _awardDB = FirebaseFirestore.instance.collection('Award');

  Future<String> addAward(AwardModel entity) async {
    try {
      String documnentid = "";
      entity.id=="non"? await _awardDB.doc().set(entity.toJson()):
      await _awardDB.doc(entity.id).set(entity.toJson());

      return documnentid;
    } catch (e) {
      print(e.toString());
    }
    return "true";
  }

  Stream<List<AwardModel>> getAllAwards() {
    return _awardDB.snapshots(includeMetadataChanges: true).map((snapshot) =>
        snapshot.docs
            .map((doc) => AwardModel.fromJson(doc.data(), doc.id))
            .toList());
  }

  Future<bool> deleteMajor(AwardModel entity) async {
    try {
      _awardDB.doc(entity.id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<List<AwardModel>> getAwardByUserId(String userID) {
    print("hiiiiiiiiiiiiii iiiiiiiiiiii ddddddddddd");
    return _awardDB
        .where('userID', isEqualTo: userID)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => AwardModel.fromJson(doc.data(), doc.id))
            .toList());
  }
}
