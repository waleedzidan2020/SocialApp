class MassegeModel {
  String? text;
  String? recevierid;
  String? senderid;
  String? datetime;
  MassegeModel.FromJason(Map<String, dynamic>? jason) {
    text = jason!['text'];
    recevierid = jason!['recevierid'];
    senderid = jason!['senderid'];
    datetime = jason!['datetime'];
  }

  MassegeModel({this.text, this.recevierid, this.senderid,this.datetime});

  Map<String, dynamic> ToMap() {
    return {
      "text": text,
      'recevierid': recevierid,
      'senderid': senderid,
      'datetime': datetime,
    };
  }
}
