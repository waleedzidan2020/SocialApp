import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_app/cubit/cubit.dart';
import 'package:socialapp/layout/social_app/cubit/states.dart';
import 'package:socialapp/models/shop_login/shop_login.dart';
import 'package:socialapp/modules/updateuser/UpdateUserScreen.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/styles/iconly_broken.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayOutCubit, SocialLayOutStates>(
      builder: (context, state) {
        var cubit = SocialLayOutCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.UserData != null,
          builder: (context) => UserProfile(context, cubit.UserData),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget UserProfile(context, UserLogin? model) => Column(
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
                  Image(
                    image: NetworkImage("${model?.cover}.png"),
                    width: double.infinity,
                    fit: BoxFit.cover,
                    height: 140,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.bottomCenter,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      child: CircleAvatar(
                        radius: 47,
                        backgroundImage: NetworkImage('${model?.image}.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            "${model?.name}",
            style: TextStyle(
              fontSize: 18,
              fontFamily: "Andika",
            ),
          ),
          InkWell(
            onTap: () {},
            child: Text(
              "${model?.bio}",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Text(
                        "${SocialLayOutCubit.get(context).NumberOfPosts}",
                        style: TextStyle(fontSize: 17, fontFamily: "Andika"),
                      ),
                      Text(
                        "Posts",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Text(
                        "100",
                        style: TextStyle(fontSize: 17, fontFamily: "Andika"),
                      ),
                      Text(
                        "Posts",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Text(
                        "100",
                        style: TextStyle(fontSize: 17, fontFamily: "Andika"),
                      ),
                      Text(
                        "Posts",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Text(
                        "100",
                        style: TextStyle(fontSize: 17, fontFamily: "Andika"),
                      ),
                      Text(
                        "Posts",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.blue,
                    height: 35,
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        "Add Photos",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    color: Colors.white,
                    height: 35,
                    width: 70,
                    child: MaterialButton(
                        onPressed: () {
                          Navigateto(context, UpdateUserScreen());
                        },
                        child: Icon(
                          IconlyBroken.edit,
                          color: Colors.blue,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
