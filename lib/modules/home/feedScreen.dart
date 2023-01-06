import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_app/cubit/cubit.dart';
import 'package:socialapp/layout/social_app/cubit/states.dart';
import 'package:socialapp/models/commentmodel/comment_model.dart';
import 'package:socialapp/models/postmodel/post_model.dart';
import 'package:socialapp/shared/styles/iconly_broken.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var TextController = TextEditingController();
    return BlocConsumer<SocialLayOutCubit, SocialLayOutStates>(
      builder: (context, state) {
        var cubit = SocialLayOutCubit.get(context).Posts;
        var cubitComment = SocialLayOutCubit.get(context).AllComment;
        var cubitCommentlIST = SocialLayOutCubit.get(context).Comment;
        return ConditionalBuilder(
          condition: state is GetPostsLoadingState,
          builder: (context) => Center(child: CircularProgressIndicator()),
          fallback: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Card(
                    elevation: 10,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Image(
                          image: NetworkImage(
                              'https://img.freepik.com/free-photo/polite-friendly-shop-assistant-ready-help-find-way-portrait-attractive-joyful-european-woman-red-loose-sweater-pointing-upper-right-corner-smiling-broadly-expressing-positive-mood_176420-13851.jpg?w=900&t=st=1672082221~exp=1672082821~hmac=8053bb71d8cc11a27f5ed1d1e947d9941797f075a2c43b757c816984b7058236.jpg'),
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Welcome To Communicate with other",
                            style:
                                TextStyle(fontFamily: "Andika", fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ConditionalBuilder(
                  condition: SocialLayOutCubit.get(context).Posts.length > 0,
                  builder: (context) => ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (cubitComment != null)
                        return BuildCard(
                            context, cubit[index], index, TextController, state,
                            Commentmodel: cubitComment[
                                        SocialLayOutCubit.get(context)!
                                            .PostId[index]] ==
                                    null
                                ? cubitComment[""]
                                : cubitComment[SocialLayOutCubit.get(context)!
                                    .PostId[index]]);
                      else
                        return BuildCard(
                          context,
                          cubit[index],
                          index,
                          TextController,
                          state,
                        );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 0),
                    itemCount: cubit.length,
                  ),
                  fallback: (context) => Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),

                //Poster
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget BuildCard(context, PostModel? model, int index,
          TextEditingController TextController, state,
          {List<CommentModel>? Commentmodel = null}) =>
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          elevation: 5.0,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage('${model?.image}'),
                      radius: 27,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${model?.name}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.verified_rounded,
                              size: 16,
                              color: Colors.blue,
                            )
                          ],
                        ),
                        Text(
                          "${model?.datetime}",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    splashRadius: 25,
                    icon: Icon(
                      Icons.more_horiz,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
              Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Text(
                    textScaleFactor: 1.1,
                    '${model?.text}',
                    style: TextStyle(fontFamily: "Andika", fontSize: 13),
                  ),
                ),
              ),
              // Container(
              //   width: double.infinity,
              //   child: Wrap(
              //     children: [
              //       Container(
              //         height: 20,
              //         child: TextButton(
              //           onPressed: () {},
              //           style: ButtonStyle(
              //               padding: MaterialStatePropertyAll(
              //                   EdgeInsets.only(left: 8)),
              //               minimumSize:
              //               MaterialStatePropertyAll(Size.zero)),
              //           child: Text(
              //             "#Software",
              //             style: TextStyle(fontSize: 15),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ), // hash tags
              if (model?.PostImage != "")
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image(
                      width: double.infinity,
                      height: 140,
                      fit: BoxFit.cover,
                      image: NetworkImage("${model?.PostImage}"),
                    ),
                  ),
                ),

              Row(
                children: [
                  MaterialButton(
                    minWidth: 4,
                    height: 35,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    onPressed: () {
                      SocialLayOutCubit.get(context).SetLike(
                          SocialLayOutCubit.get(context).PostId[index]);
                    },
                    child: Row(
                      children: [
                        Icon(
                          IconlyBroken.heart,
                          color: Colors.red,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                              '${SocialLayOutCubit.get(context).NumberOfLike[SocialLayOutCubit.get(context).PostId[index]]}',
                              style: Theme.of(context).textTheme.caption),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  MaterialButton(
                    height: 35,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    onPressed: () {
                      SocialLayOutCubit.get(context).GetAllComment(
                          postiD: SocialLayOutCubit.get(context).PostId[index]);
                    },
                    child: Row(
                      children: [
                        Icon(
                          IconlyBroken.chat,
                          color: Colors.amber,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                              '${Commentmodel?.length == null ? "" : Commentmodel?.length} Comments',
                              style: Theme.of(context).textTheme.caption),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
              MaterialButton(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                onPressed: () {},
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${SocialLayOutCubit.get(context).UserData?.image}'),
                      radius: 20,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 200,
                      height: 35,
                      child: TextFormField(
                        validator: (value) {},
                        controller: TextController,
                        onFieldSubmitted: (String value) {
                          SocialLayOutCubit.get(context).SetComment(
                              SocialLayOutCubit.get(context).PostId[index],
                              value);
                          TextController.text = "";
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Write Comment .....",
                          hintStyle: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(
                          IconlyBroken.heart,
                          color: Colors.red,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text('Like',
                              style: Theme.of(context).textTheme.caption),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                child: ListView.separated(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 180,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: MaterialButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        onPressed: () {},
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  '${Commentmodel?[index].userimage}'),
                              radius: 20,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${Commentmodel?[index].username ?? ""}',
                                  style: TextStyle(
                                    fontFamily: "Andika",
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                if (Commentmodel!.length > 0)
                                  Container(
                                    width: 180,
                                    child: Wrap(
                                      children: [
                                        Text(
                                          "${Commentmodel![index].text}",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Icon(
                                  IconlyBroken.heart,
                                  color: Colors.red,
                                  size: 18,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text('Like',
                                      style:
                                          Theme.of(context).textTheme.caption),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 0,
                  ),
                  itemCount:
                      Commentmodel?.length == null ? 0 : Commentmodel!.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              )
            ],
          ),
        ),
      );
}
