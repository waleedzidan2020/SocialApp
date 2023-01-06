import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_app/cubit/cubit.dart';
import 'package:socialapp/layout/social_app/cubit/states.dart';
import 'package:socialapp/models/massegemodel/massegemodel.dart';
import 'package:socialapp/models/shop_login/shop_login.dart';
import 'package:socialapp/shared/styles/iconly_broken.dart';

class MassegeScreen extends StatelessWidget {
  UserLogin? model;
  var MassegeController = TextEditingController();
  bool isdown=false;



  MassegeScreen(this.model);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialLayOutCubit.get(context).GetMassege(ReciverId: model?.id);
        return BlocConsumer<SocialLayOutCubit, SocialLayOutStates>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.amber,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);

                    SocialLayOutCubit.get(context).Masseges = [];
                    SocialLayOutCubit.get(context)
                        .CloseStream(ReciverId: model?.id);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                ),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage("${model?.image}"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${model?.name}',
                      style: TextStyle(fontSize: 20, fontFamily: "Andika"),
                    )
                  ],
                ),
                actions: [],
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        reverse: true,


                        controller: isdown?SocialLayOutCubit.get(context).SingleScrollController:null ,
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (SocialLayOutCubit.get(context)
                                        .Masseges[index]
                                        .senderid ==
                                    SocialLayOutCubit.get(context)
                                        .UserData
                                        ?.id) {
                                  return SenderItem(
                                      context,
                                      SocialLayOutCubit.get(context)
                                          .Masseges[index]);
                                } else {
                                  return ReciverItem(
                                      context,
                                      SocialLayOutCubit.get(context)
                                          .Masseges[index]);
                                }
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                              itemCount: SocialLayOutCubit.get(context)
                                  .Masseges
                                  .length,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey[300]),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: MassegeController,
                              decoration: InputDecoration(
                                  hintText: "Write Your Massege",
                                  border: InputBorder.none),
                            ),
                          ),
                          Container(
                            color: Colors.amber,
                            child: IconButton(
                              onPressed: () {
                                SocialLayOutCubit.get(context).SendMassege(
                                    ReciverId: model?.id,
                                    Text: MassegeController.text);
                                MassegeController.text = "";
                                isdown=true;

                              },
                              icon: Icon(
                                IconlyBroken.send,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {},
        );
      },
    );
  }

  Widget SenderItem(context, MassegeModel? model) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.all(8),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                  color: Colors.blue.withOpacity(0.5),
                ),
                child: Wrap(
                  textDirection: TextDirection.rtl,
                  direction: Axis.horizontal,
                  children: [
                    Text(
                      "${model?.text}",
                      style: TextStyle(fontSize: 15),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage(
                "${SocialLayOutCubit.get(context).UserData?.image}"),
          ),
        ],
      );

  Widget ReciverItem(context, MassegeModel? Model) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage("${model?.image}"),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.all(8),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  color: Colors.grey[400],
                ),
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    Text(
                      "${Model?.text}",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
}
