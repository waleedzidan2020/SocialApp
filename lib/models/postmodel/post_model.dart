class PostModel {

  String? name;
  String? image;
  String? uid;
  String? text;
  String? PostImage;
  String? datetime;

  PostModel.FormJason(Map<String, dynamic> jason){
    name = jason["name"];
    image = jason["image"];
    uid = jason["uid"];
    text = jason["text"];
    PostImage = jason["PostImage"];
    datetime = jason["datetime"];
  }

  PostModel({this.name,this.image,this.text,this.uid,this.PostImage,this.datetime});

   Map<String,dynamic>ToaMap(){

    return {
      "name":name,
      "image":image,
      "text":text??"",
      "uid":uid,
      "PostImage":PostImage??"",
      "datetime":datetime,

    };

}


}