

class UserLogin {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? cover;
  String? bio;


  UserLogin.FromJason(Map<String, dynamic>? jason) {
    id=jason!['id'];
    name=jason!['name'];
    email=jason!['email'];
    phone=jason!['phone'];
    image=jason!['image'];
    cover=jason!['cover'];
    bio=jason!['bio'];

  }
  UserLogin({this.name,this.email,this.phone,this.id,this.image="https://cdn-icons-png.flaticon.com/512/984/984131.png?w=740&t=st=1672596455~exp=1672597055~hmac=191b528fb0378e58161ea9ab5c821e46bb1b3bd8ed24cb26bc2c8f4514b558a8.jpg",this.bio="Write your bio",this.cover="https://img.freepik.com/free-vector/diagonal-speed-halftone-background_1409-1686.jpg?w=1060&t=st=1672595494~exp=1672596094~hmac=0fcc639c65c0346b296576450551eb636c80b8ecbc26552e5784e220a95ab3c3"}){}

  Map<String, dynamic> ToMap(){
    return {
      "name": name,
      'email':email,
      'phone':phone,
      'id':id,
      'image':image??"https://cdn-icons-png.flaticon.com/512/984/984131.png?w=740&t=st=1672596455~exp=1672597055~hmac=191b528fb0378e58161ea9ab5c821e46bb1b3bd8ed24cb26bc2c8f4514b558a8.jpg",
      'cover':cover??"",
      'bio':bio,
    };
  }
}
