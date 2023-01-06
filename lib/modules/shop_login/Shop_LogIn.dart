import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_app/cubit/cubit.dart';

import 'package:socialapp/modules/shop_register/Shop_Register.dart';
import 'package:socialapp/shared/components/constants.dart';
import 'package:socialapp/shared/network/local/cashe_helper.dart';

import '../../layout/social_app/social_layout.dart';
import '../../shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/state.dart';

class ShopLogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailcontroller = TextEditingController();
    var PasswordController = TextEditingController();

    final regs = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    GlobalKey<FormState> FormKey = GlobalKey<FormState>();
    return BlocConsumer<SocialLoginCubit,ShopLogInStates >(
      builder: (context, state) {
        var cubit = SocialLoginCubit.get(context);
        //if(state is DataSuccessLoginState){
        //   IsToken=state.LoginModel?.data?.token;
        // }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: FormKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "LogIn",
                        style: TextStyle(
                          fontFamily: "Oswald",
                          fontSize: 35,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Please Enter your personal info",
                        style: TextStyle(
                          fontFamily: "",
                          fontSize: 20,
                          color: Colors.grey[500],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Textfield(
                        padding: 0.0,
                        Label: "Enter Your Email",
                        valid: (String? value) {
                          if (value!.isEmpty) {
                            return "Please Enter your Email";
                          } else {
                            if (regs.hasMatch(emailcontroller.text)) {
                              return null;
                            } else {
                              return "Add  ***@***.com ";
                            }
                          }
                        },
                        ontap: () {},
                        Onsubmitted: (value) {
                          if (FormKey.currentState!.validate()) {}
                        },
                        passwordtext: emailcontroller,
                        prefixIcons: Icon(
                          Icons.email_outlined,
                        ),
                        KeyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Textfield(
                        padding: 0.0,
                        Label: "Enter Your Password",
                        HidePass: cubit.IsVisible,
                        valid: (String? value) {
                          if (!value!.isEmpty) {
                            if (value!.length <= 12) {
                              return null;
                            } else {
                              return "Max 12 number";
                            }
                          } else {
                            return "must enter your password";
                          }
                        },
                        ontap: () {},
                        Onsubmitted: (value) {
                          if (FormKey.currentState!.validate()) {}
                        },
                        passwordtext: PasswordController,
                        prefixIcons: Icon(
                          Icons.lock_clock_rounded,
                        ),
                        suffixIcons: IconButton(
                          onPressed: () {
                            cubit.ChangeVisiblePassword();
                          },
                          icon: Icon(
                            cubit.EyeIcon,
                          ),
                        ),
                        KeyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      ConditionalBuilder(
                        condition: state is! DataLoginLoadingState,
                        builder: (context) => LogInButton(
                          width: double.infinity,
                          TextButton: "Login",
                          fun: () {
                            if (FormKey.currentState!.validate()) {
                              if (regs.hasMatch(emailcontroller.text)) {
                                cubit.UserLogin(emailcontroller.text,
                                    PasswordController.text);
                              } else {}
                            }
                          },
                          horizontalPadding: 0.0,
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don\'t Have An Account ?",
                            style: TextStyle(fontSize: 15.0),
                          ),
                          TextButton(
                            onPressed: () {
                              NaviatAndPush(context, ShopRegisterScreen());
                            },
                            child: Text(
                              "Register",
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) async {
        var cubit = SocialLoginCubit.get(context);
        if (state is DataSuccessLoginState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Login Successfully"),
            backgroundColor: Colors.green,
            duration: Duration(
              seconds: 3,
            ),
          ));

              IsDataSuccess=true;
          CacheHelper.SaveData("uid", state.uid).then((value){
            NaviatAndPush(context, SocialLayout());

            UserId= state.uid;

          });

        } else if (state is DataErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${cubit.ErorrMessage}'),
            backgroundColor: Colors.red,
            duration: Duration(
              seconds: 3,
            ),
          ));
        }

        // Fluttertoast.showToast(
        //     msg: '${state.LoginModel!.message}',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.green,
        //     textColor: Colors.white,
        //     fontSize: 16.0);
        // } else {
        //   Fluttertoast.showToast(
        //       msg: '${state.LoginModel!.message}',
        //       toastLength: Toast.LENGTH_SHORT,
        //       gravity: ToastGravity.BOTTOM,
        //       timeInSecForIosWeb: 1,
        //       backgroundColor: Colors.red,
        //       textColor: Colors.white,
        //       fontSize: 16.0);
        //     }
        //   }
      },
    );
  }
}
