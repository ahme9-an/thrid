import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cvmaker/models/contact_model.dart';

class ContactViewModel {
  final _contactDB = FirebaseFirestore.instance.collection('Contact');

  Future<String> addContact(ContactModel entity) async {
    try {
      String documnentid = "";
      entity.id=="non"? await _contactDB.doc().set(entity.toJson()):
      await _contactDB.doc(entity.id).set(entity.toJson());

      return documnentid;
    } catch (e) {
      print(e.toString());
    }
    return "true";
  }

  Stream<List<ContactModel>> getAllMajors() {
    return _contactDB.snapshots(includeMetadataChanges: true).map((snapshot) =>
        snapshot.docs
            .map((doc) => ContactModel.fromJson(doc.data(), doc.id))
            .toList());
  }

  Future<bool> deleteMajor(ContactModel entity) async {
    try {
      _contactDB.doc(entity.id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<List<ContactModel>> getContactByUserId(String userID) {
    print("hiiiiiiiiiiiiii iiiiiiiiiiii ddddddddddd");
    return _contactDB
        .where('userID', isEqualTo: userID)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => ContactModel.fromJson(doc.data(), doc.id))
            .toList());
  }
}
