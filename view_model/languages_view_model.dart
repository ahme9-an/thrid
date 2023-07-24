import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cvmaker/models/language_model.dart';

class LanguagesViewModel {
  final _languagesDB = FirebaseFirestore.instance.collection('Languages');

  Future<String> addLanguage(LanguagesModel entity) async {
    try {
      String documnentid = "";
      entity.id=="non"? await _languagesDB.doc().set(entity.toJson()):
      await _languagesDB.doc(entity.id).set(entity.toJson());

      return documnentid;
    } catch (e) {
      print(e.toString());
    }
    return "true";
  }

  Stream<List<LanguagesModel>> getLanguages() {
    return _languagesDB.snapshots(includeMetadataChanges: true).map((snapshot) =>
        snapshot.docs
            .map((doc) => LanguagesModel.fromJson(doc.data(), doc.id))
            .toList());
  }

  Future<bool> deleteLanguagesl(LanguagesModel entity) async {
    try {
      _languagesDB.doc(entity.id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<List<LanguagesModel>> getLanguageslByUserId(String userID) {
    print("hiiiiiiiiiiiiii iiiiiiiiiiii ddddddddddd");
    return _languagesDB
        .where('userID', isEqualTo: userID)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => LanguagesModel.fromJson(doc.data(), doc.id))
            .toList());
  }
}
