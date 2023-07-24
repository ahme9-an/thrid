import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cvmaker/models/skills_model.dart';

class SkillsViewModel {
  final _skillsDB = FirebaseFirestore.instance.collection('Skills');

  Future<String> addSkill(SkillsModel entity) async {
    try {
      String documnentid = "";
      entity.id=="non"? await _skillsDB.doc().set(entity.toJson()):
      await _skillsDB.doc(entity.id).set(entity.toJson());

      return documnentid;
    } catch (e) {
      print(e.toString());
    }
    return "true";
  }

  Stream<List<SkillsModel>> getSkills() {
    return _skillsDB.snapshots(includeMetadataChanges: true).map((snapshot) =>
        snapshot.docs
            .map((doc) => SkillsModel.fromJson(doc.data(), doc.id))
            .toList());
  }

  Future<bool> deleteSkills(SkillsModel entity) async {
    try {
      _skillsDB.doc(entity.id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<List<SkillsModel>> getSkillsByUserId(String userID) {
    print("hiiiiiiiiiiiiii iiiiiiiiiiii ddddddddddd");
    return _skillsDB
        .where('userID', isEqualTo: userID)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => SkillsModel.fromJson(doc.data(), doc.id))
            .toList());
  }
}
