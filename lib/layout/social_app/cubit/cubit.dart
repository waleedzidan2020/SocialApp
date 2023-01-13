import 'dart:async';
import 'dart:core';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/layout/social_app/cubit/states.dart';
import 'package:socialapp/layout/social_app/social_layout.dart';
import 'package:socialapp/models/commentmodel/comment_model.dart';
import 'package:socialapp/models/massegemodel/massegemodel.dart';
import 'package:socialapp/models/postmodel/post_model.dart';
import 'package:socialapp/models/shop_login/shop_login.dart';
import 'package:socialapp/modules/chats/ChatsScreen.dart';
import 'package:socialapp/modules/home/feedScreen.dart';
import 'package:socialapp/modules/posts/postScreen.dart';
import 'package:socialapp/modules/settings/settingScreen.dart';

import 'package:socialapp/modules/users/UserScreen.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/components/constants.dart';
import 'package:socialapp/shared/styles/iconly_broken.dart';

import '../../../modules/Social_login/Shop_LogIn.dart';

class SocialLayOutCubit extends Cubit<SocialLayOutStates> {
  SocialLayOutCubit() : super(SocialLayOutInit());

  static SocialLayOutCubit get(context) => BlocProvider.of(context);

  UserLogin? UserData;

  PickedFile? PickedProfileImage;
  PickedFile? PickedCoverImage;
  File? ProfileImage;
  File? CoverImage;
  String? PathImage;
  String? DownLoadImagePath;
  String? DownLoadImagePathCover;

  ImagePicker? _picker = ImagePicker();

  void UploadeCoverImage() async {
    PickedCoverImage = await _picker!.getImage(source: ImageSource.gallery);
    if (PickedCoverImage != null) {
      // Pick an image

      CoverImage = File(PickedCoverImage!.path);
    } else {
      print('Not Image Selecet');
    }
  }

  void UploadeProfileImage() async {
    PickedProfileImage = await _picker!.getImage(source: ImageSource.gallery);
    if (PickedProfileImage != null) {
      // Pick an image

      ProfileImage = File(PickedProfileImage!.path);
    } else {
      print('Not Image Selecet');
    }
  }

  void SaveProfileImage() {
    emit(LoadingSaveProfileImageState());
    FirebaseStorage.instance
        .ref()
        .child("Users/${Uri.file(ProfileImage!.path).pathSegments.last}")
        .putFile(ProfileImage!)
        .then((value) async {
      await value.ref.getDownloadURL().then((value) {
        DownLoadImagePath = value;
        emit(SaveProfileToServerSuccessState());
      }).catchError((error) {
        print(error);
        emit(SaveProfileToServerErorrState());
      });
    }).catchError((error) {
      print(error);
    });
  }

  void SaveCoverImage() {
    emit(LoadingSaveCoverImageState());
    FirebaseStorage.instance
        .ref()
        .child("Users/${Uri.file(CoverImage!.path).pathSegments.last}")
        .putFile(CoverImage!)
        .then((value) async {
      await value.ref.getDownloadURL().then((value) {
        DownLoadImagePathCover = value;
        emit(SaveCoverToServerSuccessState());
      }).catchError((error) {
        print(error);
        emit(SaveCoverToServerErorrState());
      });
    }).catchError((error) {
      print(error);
    });
  }

  void SignOut(context) {
    FirebaseAuth.instance.signOut().then((value) {
      NaviatAndPush(context, ShopLogInScreen());
      emit(SignOutSuccessState());
    }).catchError((error) {
      print(error);
    });
  }

  void UpdateProfile({
    @required String? phone,
    @required String? name,
    @required String? bio,
  }) {
    if (DownLoadImagePath != null || DownLoadImagePathCover != null) {
      UpdateUser(
          bio: bio,
          name: name,
          phone: phone,
          image: DownLoadImagePath,
          cover: DownLoadImagePathCover);
    } else {
      UpdateUser(
        bio: bio,
        name: name,
        phone: phone,
      );
    }
  }

  void UpdateUser(
      {@required String? phone,
      @required String? name,
      @required String? bio,
      String? image,
      String? cover}) {
    UserLogin? model = UserLogin(
        phone: phone,
        name: name,
        id: UserData?.id,
        email: UserData?.email,
        image: image == null ? UserData?.image : image,
        bio: bio,
        cover: cover == null ? UserData?.cover : cover);

    FirebaseFirestore.instance
        .collection("Users")
        .doc(UserId)
        .update(model.ToMap())
        .then((value) {
      GettUser();
      emit(UpdateUserSuccessState());
    }).catchError((error) {
      emit(UpdateUserErorrState());
    });
  }

  void GettUser() {
    emit(UserDataLoadingState());
    FirebaseFirestore.instance
        .collection("Users")
        .doc(UserId)
        .get()
        .then((value) {
      print(value.data());
      UserData = UserLogin.FromJason(value.data());
      print(UserData?.image);
      emit(UserDataSuccessState());
    }).catchError((error) {
      print(error);
      emit(UserDataErrorState());
    });
  }

  List<BottomNavigationBarItem> ListOfIcon = [
    BottomNavigationBarItem(
      icon: Icon(
        IconlyBroken.home,
      ),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(IconlyBroken.chat),
      label: "Chats",
    ),
    BottomNavigationBarItem(
      icon: Icon(IconlyBroken.activity),
      label: "Posts",
    ),
    BottomNavigationBarItem(
      icon: Icon(IconlyBroken.user2),
      label: "Users",
    ),
    BottomNavigationBarItem(
      icon: Icon(IconlyBroken.setting),
      label: "Settings",
    ),
  ];

  List<Widget> ListOfScreen = [
    HomeScreen(),
    ChatsScreen(),
    PostsScreen(),
    UserScreen(),
    SettingScreen()
  ];

  int CurrentIndex = 0;

  void ChangeBottomNavigate(int CurrentIndex) {
    if (CurrentIndex == 2) {
      emit(PostsState());
    } else {
      this.CurrentIndex = CurrentIndex;

      emit(ChangeBottomNavigateState());
    }

    if (CurrentIndex == 0) {
      GetPosts();
    }

    if (CurrentIndex == 1) {
      GetAllUsers();
    }
  }

  File? PostImage;
  PickedFile? PickedPostImage;
  String? DownLoadPostImagePath;

  void UploadePostImage() async {
    PickedPostImage = await _picker!.getImage(source: ImageSource.gallery);
    if (PickedPostImage != null) {
      // Pick an image

      PostImage = File(PickedPostImage!.path);
      emit(PickedPostSuccessState());
    } else {
      print('Not Image Selecet');
      emit(PickedPostErrorState());
    }
  }

  void SavePostImage({@required String? Text}) {
    emit(LoadingSavePostImageState());
    FirebaseStorage.instance
        .ref()
        .child("Posts/${Uri.file(PostImage!.path).pathSegments.last}")
        .putFile(PostImage!)
        .then((value) async {
      await value.ref.getDownloadURL().then((value) {
        DownLoadPostImagePath = value;
        print(DownLoadPostImagePath);
        CreatePost(
          PostImage: DownLoadPostImagePath,
          Text: Text,
        );
        emit(SavePostImageToServerSuccessState());
      }).catchError((error) {
        print(error);
        emit(SavePostImageeToServerErorrState());
      });
    }).catchError((error) {
      print(error);
    });
  }

  void ClosePostImage() {
    PostImage = null;
    emit(ClosePostImageState());
  }

  void CreatePost({
    @required String? Text,
    @required String? PostImage,
  }) {
    final now = DateTime.now();
    PostModel model = PostModel(
      text: Text,
      name: UserData?.name,
      image: UserData?.image,
      uid: UserData?.id,
      PostImage: PostImage ?? '',
      datetime: now.toString(),
    );
    emit(CreatePostLoaginState());
    FirebaseFirestore.instance
        .collection("Posts")
        .add(model.ToaMap())
        .then((value) {
      GetPosts();
      emit(CreatePostSuccessState(PostImage));
    }).catchError((erorr) {
      emit(CreatePostErrorState());
    });
  }

  List<PostModel> Posts = [];
  List<String> PostId = [];
  Map<String, int> NumberOfLike = {};

  // List<String> NumberOfPosts = [];
  int? NumberOfPosts = 0;

  void GetNumberOfPosts() {
    // NumberOfPosts = [];

    NumberOfPosts = 0;
    Posts.forEach((element) {
      if (UserData?.id == element.uid)
        // NumberOfPosts.add(element.text!);
        NumberOfPosts = NumberOfPosts! + 1;
    });

    emit(NumberOfPostsSuccessState());
  }

  void UpdateNameforUserinPost(String postid) {
    Posts.forEach((element) {
      if (element.uid == UserData?.id) {
        // FirebaseFirestore.instance.collection("Posts").doc(postid).update({
        //
        //   "image":UserData?.image,
        //   "name":UserData?.name
        //
        // }).then((value){
        //   emit(UdpatePostSucessState());
        // }).catchError((erorr){
        //   print(erorr.toString());
        //   emit(UdpatePostErorrState());
        // });
        element.name = UserData?.name;
        element.image = UserData?.image;
      }
    });
  }

  void GetPosts() {
    emit(GetPostsLoadingState());
    Posts = [];
    PostId = [];
    NumberOfLike = {};
    FirebaseFirestore.instance.collection("Posts").get().then((value) {
      value.docs.forEach((element) {
        PostId.add(element.id);
        // GetAllComment(postiD: element.id);
        print(element.id);
        GetNumberOfLikes(element.id);
        Posts.add(PostModel.FormJason(element.data()));
      });
      GetNumberOfPosts();
      emit(GetPostsSuccessState(PostId));
    }).catchError((erorr) {
      print(erorr.toString());
      emit(GetPostsErorrState());
    });
  }
int? NumberOfLIke=0;
  void GetNumberOfLikes(String postid) {
    emit(LodingLikeState());

    FirebaseFirestore.instance
        .collection("Posts")
        .doc(postid)
        .collection("like")
        .get()
        .then((value) {
      NumberOfLike.addAll({"${postid}": value.docs.length!});
      NumberOfLIke =value.docs.length;
      emit(UpdateLikeSuccessState());
    }).catchError((erorr) {
      emit(UpdateLikeErorrState());

      print(erorr.toString());
    });
  }

  void SetLike(String postid) {
    FirebaseFirestore.instance
        .collection("Posts")
        .doc(postid)
        .collection("like")
        .add({"Like": true, "uid": UserData?.id}).then((value) {
      NumberOfLIke=NumberOfLIke!+1;
      emit(LikePostSuccessState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(LikePostErorrState());
    });
  }

  void SetComment(@required String Postid, @required String text) {
    FirebaseFirestore.instance
        .collection("Posts")
        .doc(Postid)
        .collection("comments")
        .add({
      "text": text,
      "uid": UserData?.id,
      "userimage": UserData?.image,
      'username': UserData?.name
    }).then((value) {
      print(value.toString());
      emit(SetCommentsSuccessState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(SetCommentsErorrState());
    });
  }

  Map<String, List<CommentModel>> AllComment = {};
  List<CommentModel> Comment = [];

  void GetAllComment({@required String? postiD}) {
    AllComment = {};
    Comment = [];
    FirebaseFirestore.instance
        .collection("Posts")
        .doc(postiD)
        .collection("comments")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        GetComment(commentid: element.id, postiD: postiD);
      });
      AllComment.addAll({postiD!: Comment});

      emit(GetCommentsSuccessState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(GetCommentsErorrState());
    });
  }

  void GetComment({@required String? postiD, @required String? commentid}) {
    Comment = [];
    FirebaseFirestore.instance
        .collection("Posts")
        .doc(postiD)
        .collection("comments")
        .doc(commentid)
        .get()
        .then((value) {
      CommentModel model = CommentModel.FromJason(value.data()!);
      print(model.text);

      Comment.add(model);

      emit(GetOneCommentSuccessState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(GetOneCommentErorrState());
    });
  }

  List<UserLogin>? ListUsers = [];

  void GetAllUsers() {
    ListUsers = [];
    emit(GetAllUserLoadingState());
    FirebaseFirestore.instance.collection("Users").get().then((value) {
      value.docs.forEach((element) {
        if (element.id != UserData?.id)
          ListUsers?.add(UserLogin.FromJason(element.data()));
      });
      emit(GetAllUserSuccessState());
    }).catchError((error) {
      print(error);

      emit(GetAllUserErorrState());
    });
  }

  List<MassegeModel> Masseges = [];

  void SendMassege({@required String? ReciverId, @required String? Text}) {
    MassegeModel model = MassegeModel(
        recevierid: ReciverId,
        datetime: DateTime?.now().toString(),
        senderid: UserData?.id,
        text: Text);
    FirebaseFirestore.instance
        .collection("Users")
        .doc(UserData?.id)
        .collection("Chats")
        .doc(ReciverId)
        .collection("Massege")
        .add(model.ToMap())
        .then((value) {
      emit(SendMassegeSuccessState());
    }).catchError((erorr) {
      print(erorr);
      emit(SendMassegeErorrState());
    });

    FirebaseFirestore.instance
        .collection("Users")
        .doc(ReciverId)
        .collection("Chats")
        .doc(UserData?.id)
        .collection("Massege")
        .add(model.ToMap())
        .then((value) {
      emit(SendMassegeSuccessState());
    }).catchError((erorr) {
      print(erorr);
      emit(SendMassegeErorrState());
    });
  }

  var SingleScrollController = ScrollController();

  void ScrollDown() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SingleScrollController.animateTo(
              SingleScrollController.position.maxScrollExtent,
              duration: Duration(seconds: 1),
              curve: Curves.ease)
          .then((value) async {
        await Future.delayed(Duration(seconds: 2));
        SingleScrollController.animateTo(
            SingleScrollController.position.minScrollExtent,
            duration: Duration(seconds: 1),
            curve: Curves.ease);
        emit(ScrollDownState());
      });
    });
  }

  void GetMassege({@required String? ReciverId}) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(UserData?.id)
        .collection("Chats")
        .doc(ReciverId)
        .collection("Massege")
        .orderBy("datetime", descending: false)
        .snapshots()
        .listen((event) {
      Masseges = [];
      event.docs.forEach((element) {
        Masseges.add(MassegeModel.FromJason(element.data()));
      });
    });
  }

  void CloseStream({@required String? ReciverId}) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(UserData?.id)
        .collection("Chats")
        .doc(ReciverId)
        .collection("Massege")
        .orderBy("datetime", descending: false)
        .snapshots()
        .listen((event) {})
        .cancel();
  }
}
