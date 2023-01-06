import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_app/cubit/cubit.dart';
import 'package:socialapp/layout/social_app/cubit/states.dart';
import 'package:socialapp/models/shop_login/shop_login.dart';
import 'package:socialapp/modules/chats/MassegeScreen.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayOutCubit, SocialLayOutStates>(
      builder: (context, state) {
        var cubit = SocialLayOutCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return BuildChatItem(cubit.ListUsers?[index],context,index);
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: 20,
                  ),
                  itemCount: cubit.ListUsers!.length,
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget BuildChatItem(UserLogin? model,context,int? index) => InkWell(
        onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MassegeScreen(model),));
        SocialLayOutCubit.get(context).GetMassege(ReciverId: model?.id);
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  "${model?.image??"https://cdn-icons-png.flaticon.com/512/957/957284.png?w=740&t=st=1672593552~exp=1672594152~hmac=d95d635fa1ef27e6f45bebff68e9064875440e4882b1b5cea1bb6d1200cf47ed.png"}"),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "${model?.name}",
              style: TextStyle(fontFamily: "Andika", fontSize: 20),
            ),

            // if(SocialLayOutCubit.get(context).Masseges[index!].text=="")

          ],
        ),
      );
}
