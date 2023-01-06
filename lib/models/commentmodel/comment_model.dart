class CommentModel {
  String? text;
  String? uid;
  String? username;
  String? userimage;

  CommentModel({this.text, this.uid, this.userimage, this.username});

  CommentModel.FromJason(Map<String, dynamic> jason) {
    text = jason["text"];
    uid = jason["uid"];
    username = jason["username"];
    userimage = jason["userimage"];
  }

  Map<String, dynamic> ToMap() {
    return {
      'text': text,
      'uid': uid,
      'username': username,
      'userimage': userimage
    };
  }
}
