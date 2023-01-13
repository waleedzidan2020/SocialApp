import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/shared/components/components.dart';

import '../Social_login/Shop_LogIn.dart';
import 'cubit/States.dart';
import 'cubit/cubit.dart';



class ShopRegisterScreen extends StatelessWidget {
  GlobalKey<FormState> keyRegister = GlobalKey<FormState>();
  var EmailController = TextEditingController();

  var UserNameController = TextEditingController();
  var PasswordController = TextEditingController();
  var PhoneController = TextEditingController();
  RegExp rex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          var cubit = RegisterCubit.get(context);
          if (state is DataCreateSuccessState) {
            NaviatAndPush(context, ShopLogInScreen());
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Register Complete"),
              backgroundColor: Colors.green,
              duration: Duration(
                seconds: 3,
              ),
            ));
          } else if(state is  DataCreateErorrState && state is DataRegisterErorrState){


            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("${cubit.ErrorMessage}"),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: keyRegister,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: "MartianMono",
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Register For Our APP to Shop Now",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Oswald",
                            color: Colors.grey[500],
                            height: 1.5),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Textfield(
                        valid: (String? Value) {
                          if (Value!.isEmpty) {
                            return "Must Fill this Field";
                          } else {
                            return null;
                          }
                        },
                        passwordtext: UserNameController,
                        Label: "User Name",
                        padding: 0.0,
                        KeyboardType: TextInputType.text,
                        prefixIcons: Icon(
                          Icons.text_format,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Textfield(
                        valid: (String? Value) {
                          if (Value!.isEmpty) {
                            return "Must Fill this Field";
                          } else {
                            if (rex.hasMatch(Value) == true) {
                              return null;
                            } else
                              return "Add @****.***";
                          }
                        },
                        passwordtext: EmailController,
                        Label: "Email",
                        padding: 0.0,
                        KeyboardType: TextInputType.emailAddress,
                        prefixIcons: Icon(
                          Icons.email_outlined,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Textfield(
                        valid: (String? Value) {
                          if (Value!.isEmpty) {
                            return "Must Fill this Field";
                          } else
                            return null;
                        },
                        passwordtext: PasswordController,
                        Label: "Password",
                        padding: 0.0,
                        KeyboardType: TextInputType.phone,
                        HidePass: cubit.IsHide,
                        prefixIcons: Icon(
                          Icons.lock_clock_rounded,
                        ),
                        suffixIcons: IconButton(
                          onPressed: () {
                            cubit.ChangeHidePassword(cubit.IsHide);
                          },
                          icon: Icon(
                            cubit.HideIcon,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Textfield(
                        valid: (String? Value) {
                          if (Value!.isEmpty) {
                            return "Must Fill this Field";
                          } else
                            return null;
                        },
                        passwordtext: PhoneController,
                        Label: "Phone",
                        padding: 0.0,
                        KeyboardType: TextInputType.phone,
                        prefixIcons: Icon(
                          Icons.phone,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      LogInButton(
                        width: double.infinity,
                        fun: () {
                          if (keyRegister.currentState!.validate()) {
                            cubit.PostData(
                                EmailController.text,
                                PasswordController.text,
                                PhoneController.text,
                                UserNameController.text);
                          }
                        },
                        horizontalPadding: 0.0,
                        TextButton: "Register",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
