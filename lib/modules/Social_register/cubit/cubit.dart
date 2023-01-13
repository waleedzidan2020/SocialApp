import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/shop_login/shop_login.dart';
import 'package:socialapp/models/shop_register/shop_register.dart';
import 'package:socialapp/shared/components/constants.dart';

import 'States.dart';



class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegsiterInitState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  RegisterModel? registermodel;
  bool IsHide = true;
  IconData? HideIcon = Icons.remove_red_eye;

  void ChangeHidePassword(IsHide) {
    this.IsHide = !IsHide;
    HideIcon =
        this.IsHide ? Icons.remove_red_eye : Icons.remove_red_eye_outlined;

    emit(ChangeHidePasswordState());
  }

  String? ErrorMessage;

  void PostData(@required String? email, @required String? password,
      @required String? phone, @required String? name) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .then((value) {


      emit(DataRegisterSuccessState());
      CreateUserData(
        id: value.user!.uid,
        name: name,
        phone: phone,
        email: email,
      );


    }).catchError((error) {
      ErrorMessage = error.toString().split("]")[1];
      print(error);
      emit(DataRegisterErorrState());
    });

    //  DioHelper.PostNewData(url: Register, email: email, password: password, phone: phone, name: name).then((value){
    //    registermodel=RegisterModel.FormJason(value.data);
    //    print(registermodel?.message);
    //    emit(DataRegisterSuccessState());
    //
    //  }).catchError((erorr){
    //    print(erorr.toString());
    // emit(DataRegisterErorrState());
    //  });
  }

  void CreateUserData(
      {@required String? email,
      @required String? id,
      @required String? phone,
      @required String? name}) {
    UserLogin model = UserLogin(email: email, name: name, phone: phone, id: id);
    emit(DataCreateLoadingState());
    FirebaseFirestore.instance
        .collection('Users')
        .doc(model.id)
        .set(model.ToMap())
        .then((value) {

      emit(DataCreateSuccessState());
    }).catchError((Error) {
      print(Error);
      emit(DataCreateErorrState());
    });
  }
}
