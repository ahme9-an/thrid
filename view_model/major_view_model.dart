import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cvmaker/models/major_model.dart';

class MajorViewModel {
  final _majorDB = FirebaseFirestore.instance.collection('Major');

  Future<String> addMajor(MajorModel entity) async {
    try {
      String documnentid = "";
      await _majorDB
          .add(entity.toJson())
          .then((value) => documnentid = value.id);

      return documnentid;
    } catch (e) {
      print(e.toString());
    }
    return "true";
  }

  Stream<List<MajorModel>> getAllMajors() {
    return _majorDB.snapshots(includeMetadataChanges: true).map((snapshot) =>
        snapshot.docs
            .map((doc) => MajorModel.fromJson(doc.data(), doc.id))
            .toList());
  }

   Future<bool> deleteMajor(MajorModel entity) async {
   
    try {
      _majorDB
          .doc(entity.id)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
