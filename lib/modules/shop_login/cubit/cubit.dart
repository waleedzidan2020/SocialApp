import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:socialapp/modules/shop_login/cubit/state.dart';
import 'package:socialapp/shared/components/constants.dart';

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




  void UserLogin(
    @required String? email,
    @required String? password,
  ) {
    emit(DataLoginLoadingState());
   FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!).then((value){
     print(value.user!.uid);

     emit(DataSuccessLoginState(value.user!.uid));
   }).catchError((error){
     ErorrMessage=error.toString().split("]")[1];

     emit(DataErrorState());
   });

  }
}
