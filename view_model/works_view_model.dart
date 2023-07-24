import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cvmaker/models/work_model.dart';

class WorksViewModel {
  final _workDB = FirebaseFirestore.instance.collection('Works');

  Future<String> addWork(WorkModel entity) async {
    try {
      String documnentid = "";
      entity.id == "non"
          ? await _workDB.doc().set(entity.toJson())
          : await _workDB.doc(entity.id).set(entity.toJson());

      return documnentid;
    } catch (e) {
      print(e.toString());
    }
    return "true";
  }

  Stream<List<WorkModel>> getWorks() {
    return _workDB.snapshots(includeMetadataChanges: true).map(
        (snapshot) => snapshot.docs
            .map((doc) => WorkModel.fromJson(doc.data(), doc.id))
            .toList());
  }

  Future<bool> deleteWork(WorkModel entity) async {
    try {
      _workDB.doc(entity.id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<List<WorkModel>> getWorksByUserId(String userID) {
    return _workDB
        .where('userID', isEqualTo: userID)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => WorkModel.fromJson(doc.data(), doc.id))
            .toList());
  }
}
