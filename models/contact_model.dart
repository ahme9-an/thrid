class ContactModel {
  String? id;
  String? phoneNo;
  String? email;
  String? address;
  String? userID;

  ContactModel({this.id,this.userID, this.phoneNo, this.email, this.address});
  ContactModel.fromJson(
    Map<String, dynamic>? json,
    String docId,
  ) {
    id = docId;
    phoneNo = json!['phoneNo'];
    email = json['email'];
    address = json['address'];
        userID = json['userID'];

  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'phoneNo': phoneNo,
      "email": email,
      "address": address,
      "userID": userID,
    };
  }
}
