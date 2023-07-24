import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/education_model.dart';

class EducationViewModel {
  final _educationDB = FirebaseFirestore.instance.collection('Education');

  Future<String> addEducation(EducationModel entity) async {
    try {
      String documnentid = "";
      entity.id == "non"
          ? await _educationDB.doc().set(entity.toJson())
          : await _educationDB.doc(entity.id).set(entity.toJson());

      return documnentid;
    } catch (e) {
      print(e.toString());
    }
    return "true";
  }

  Stream<List<EducationModel>> getEducations() {
    return _educationDB.snapshots(includeMetadataChanges: true).map(
        (snapshot) => snapshot.docs
            .map((doc) => EducationModel.fromJson(doc.data(), doc.id))
            .toList());
  }

  Future<bool> deleteEducation(EducationModel entity) async {
    try {
      _educationDB.doc(entity.id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<List<EducationModel>> getEducationsByUserId(String userID) {
    return _educationDB
        .where('userID', isEqualTo: userID)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => EducationModel.fromJson(doc.data(), doc.id))
            .toList());
  }
}
