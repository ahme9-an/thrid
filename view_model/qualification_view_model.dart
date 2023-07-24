import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cvmaker/models/qualification_model.dart';

class QualificationViewModel {
  final _qualificationDB = FirebaseFirestore.instance.collection('Qualification');

  Future<String> addQualificatios(QualificationModel entity) async {
    try {
      String documnentid = "";
      await _qualificationDB
          .add(entity.toJson())
          .then((value) => documnentid = value.id);

      return documnentid;
    } catch (e) {
      print(e.toString());
    }
    return "true";
  }

  Stream<List<QualificationModel>> getAllQualificatios() {
    return _qualificationDB.snapshots(includeMetadataChanges: true).map((snapshot) =>
        snapshot.docs
            .map((doc) => QualificationModel.fromJson(doc.data(), doc.id))
            .toList());
  }

   Future<bool> deleteQualificatios(QualificationModel entity) async {
   
    try {
      _qualificationDB
          .doc(entity.id)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
