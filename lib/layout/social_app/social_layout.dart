import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_app/cubit/cubit.dart';
import 'package:socialapp/layout/social_app/cubit/states.dart';
import 'package:socialapp/modules/posts/postScreen.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/components/constants.dart';
import 'package:socialapp/shared/network/local/cashe_helper.dart';
import 'package:socialapp/shared/styles/iconly_broken.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayOutCubit, SocialLayOutStates>(
      builder: (context, state) {

        var cubit = SocialLayOutCubit.get(context);
        if(IsDataSuccess==true){
          cubit.GettUser();
          cubit.GetPosts();

          IsDataSuccess=false;
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "NewsFeeds",
              style: TextStyle(fontFamily: "Andika"),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(IconlyBroken.search),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(IconlyBroken.notification),
              ),
              IconButton(
                onPressed: () {
                  cubit.SignOut(context);
                },
                icon: Icon(IconlyBroken.logout),
              ),
            ],
          ),
          body: cubit.ListOfScreen[cubit.CurrentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: cubit.ListOfIcon,
            onTap: (index) {
              cubit.ChangeBottomNavigate(index);
            },
            currentIndex: cubit.CurrentIndex,
          ),
        );
      },
      listener: (context, state) {
        var cubit = SocialLayOutCubit.get(context);
        if (state is PostsState) {
          Navigateto(context, PostsScreen());
        }


        // if (state is ChangeBottomNavigateState) {
        //   if (cubit.CurrentIndex == 0 || cubit.CurrentIndex == 4)
        //     cubit.GettUser();
        // }

        if (state is SignOutSuccessState) {
          CacheHelper.RemoveToken("uid").then((value) {

            IsDataSuccess=false;
            print("Removed");
          });
        }
      },
    );
  }
}
