import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_app/cubit/cubit.dart';
import 'package:socialapp/layout/social_app/cubit/states.dart';
import 'package:socialapp/shared/components/components.dart';

class UpdateUserScreen extends StatelessWidget {
  var NameController = TextEditingController();
  var Biocontroller = TextEditingController();
  var PhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayOutCubit, SocialLayOutStates>(
      builder: (context, state) {
        var model = SocialLayOutCubit.get(context).UserData;
        var cubit = SocialLayOutCubit.get(context);
        NameController.text = model!.name!;
        Biocontroller.text = model!.bio!;
        PhoneController.text = model!.phone!;

        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Profile Edit",
                style: TextStyle(fontSize: 20, fontFamily: "Andika"),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    cubit.UpdateProfile(
                        phone: PhoneController.text,
                        name: NameController.text,
                        bio: Biocontroller.text);
                  },
                  child: Text(
                    "Update",
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 180,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Stack(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              ConditionalBuilder(
                                condition: state is SaveProfileToServerSuccessState ||  state is SaveCoverToServerSuccessState ||state is UserDataSuccessState ,
                                builder:  (context) =>  Image(
                                  image: FileImage(cubit.CoverImage!),
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  height: 140,
                                ),
                                fallback: (context) => Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3.0,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CircleAvatar(
                                  radius: 17,
                                  child: IconButton(
                                    onPressed: () {
                                      cubit.UploadeCoverImage();
                                    },
                                    icon: Icon(
                                      Icons.camera_alt,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.bottomCenter,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 50,
                                  child: ConditionalBuilder(
                                    condition: state
                                            is SaveProfileToServerSuccessState ||
                                        state
                                            is SaveCoverToServerSuccessState ||
                                        state is UserDataSuccessState,
                                    builder: (context) => CircleAvatar(
                                        radius: 47,
                                        backgroundImage:
                                            FileImage(cubit.ProfileImage!)),
                                    fallback: (context) => Center(
                                        child: CircularProgressIndicator(
                                      strokeWidth: 3.0,
                                    )),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 16,
                                  child: IconButton(
                                    onPressed: () {
                                      cubit.UploadeProfileImage();
                                    },
                                    icon: Icon(
                                      Icons.camera_alt,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  LogInButton(
                    width: double.infinity,
                    fun: () {
                      if (cubit.PickedProfileImage != null)
                        cubit.SaveProfileImage();
                      if (cubit.PickedCoverImage != null) {
                        cubit.SaveCoverImage();
                      } else {}
                    },
                    TextButton: "uploade photo",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Textfield(
                      padding: 10,
                      passwordtext: NameController,
                      prefixIcons: Icon(Icons.perm_identity_rounded),
                      valid: (String? value) {
                        if (value!.isEmpty) {
                          return "please fill this field";
                        } else
                          return null;
                      },
                      Label: "Name",
                      KeyboardType: TextInputType.text),
                  Textfield(
                      padding: 10,
                      passwordtext: Biocontroller,
                      valid: (String? value) {
                        if (value!.isEmpty) {
                          return "please fill this field";
                        } else
                          return null;
                      },
                      Label: "Bio",
                      prefixIcons: Icon(Icons.messenger_outline),
                      KeyboardType: TextInputType.text),
                  Textfield(
                    padding: 10,
                    passwordtext: PhoneController,
                    valid: (String? value) {
                      if (value!.isEmpty) {
                        return "please fill this field";
                      } else
                        return null;
                    },
                    Label: "PhoneNumber",
                    KeyboardType: TextInputType.text,
                    prefixIcons: Icon(Icons.phone),
                  ),
                ],
              ),
            ));
      },
      listener: (context, state) {},
    );
  }
}
