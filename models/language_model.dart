class LanguagesModel {
  String? id;
  String? title;
  int? reading;
  int? writing;
  int? listening;
  int? speaking;
  String? userID;

  LanguagesModel(
      {this.id,
      this.title,
      this.reading,
      this.writing,
      this.listening,
      this.speaking,
      this.userID});
  LanguagesModel.fromJson(
    Map<String, dynamic>? json,
    String docId,
  ) {
    id = docId;
    title = json!['title'];
    reading = json['reading'];
    writing = json['writing'];
    listening = json['listening'];
    speaking = json['speaking'];
    userID = json['userID'];
  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'title': title,
      "userID": userID,
      "reading": reading,
      "writing": writing,
      "listening": listening,
      "speaking": speaking,
    };
  }
}
