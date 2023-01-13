import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:socialapp/modules/Social_login/cubit/state.dart';

import '../../../models/shop_login/shop_login.dart';
import '../../Social_register/cubit/States.dart';

class SocialLoginCubit extends Cubit<ShopLogInStates> {
  SocialLoginCubit() : super(ShopLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  bool IsVisible = true;
  IconData EyeIcon = Icons.remove_red_eye;
  String? ErorrMessage;

  void ChangeVisiblePassword() {
    IsVisible = !IsVisible;
    EyeIcon =
        IsVisible ? Icons.remove_red_eye : Icons.disabled_visible_outlined;
    emit(PasswordVisibleState());
  }

  void SignIn(
    @required String? email,
    @required String? password,
  ) {
    emit(DataLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      print(value.user!.uid);

      emit(DataSuccessLoginState(value.user!.uid));
    }).catchError((error) {
      ErorrMessage = error.toString().split("]")[1];

      emit(DataErrorState());
    });
  }

  void CreateUserByGamil(
      {@required String? email,
      @required String? id,
      @required String? phone,
      @required String? name}) {
    UserLogin model = UserLogin(email: email, name: name, phone: phone, id: id);
    emit(DataCreateLoadingByGmailState());
    FirebaseFirestore.instance
        .collection('Users')
        .doc(model.id)
        .set(model.ToMap())
        .then((value) {
      emit(DataCreateSuccessByGmailState(model.id));
    }).catchError((Error) {
      print(Error);
      emit(DataCreateErorrByGmailState());
    });
  }

  Future<GoogleSignInAuthentication?> AuthenticateGmailByGoogle() async {
    GoogleSignInAccount? user = await SignInByGmail();

    return await user?.authentication;
  }

  Future<GoogleSignInAccount?> SignInByGmail() async {
    GoogleSignIn acount = GoogleSignIn(scopes: ["email"]);

    return await acount.signIn();
  }



  OAuthCredential AddCredential(GoogleSignInAuthentication? GoogleAuth) {
    OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: GoogleAuth?.accessToken, idToken: GoogleAuth?.idToken);
    return credential;
  }

  void StoreInFireBaseAuthenticationAndCreateAcountInFireBaseStore() async {
    GoogleSignInAuthentication? GoogleAuth = await AuthenticateGmailByGoogle();

    FirebaseAuth.instance
        .signInWithCredential(AddCredential(GoogleAuth))
        .then((value) {
      print(value.user?.email);
      CreateUserByGamil(
        name: value.user?.displayName,
        phone: value.user?.phoneNumber,
        email: value.user?.email,
        id: value.user?.uid,
      );
      emit(FireBaseAuthenticationSuccess());
    }).catchError((erorr) {
      print(erorr.toString());

      emit(FireBaseAuthenticationErorr());
    });
  }
}
