import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_app/cubit/cubit.dart';
import 'package:socialapp/layout/social_app/cubit/states.dart';
import 'package:socialapp/layout/social_app/social_layout.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/styles/iconly_broken.dart';

class PostsScreen extends StatelessWidget {
  var TextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayOutCubit, SocialLayOutStates>(
      builder: (context, state) {
        var model = SocialLayOutCubit.get(context).UserData;
        var cubit = SocialLayOutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
            ),
            title: Text(
              "Create Post",
              style: TextStyle(
                fontFamily: "Andika",
                fontSize: 21,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (cubit.PostImage != null) {
                    cubit.SavePostImage(Text: TextController.text);
                    NaviatAndPush(context, SocialLayout());
                    cubit.GetPosts();
                    cubit.GettUser();
                  } else {
                    cubit.CreatePost(Text: TextController.text, PostImage: "");
                    NaviatAndPush(context, SocialLayout());
                    cubit.GetPosts();
                    cubit.GettUser();
                  }
                },
                child: Text(
                  "Post",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          body: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage('${model!.image}'),
                      radius: 27,
                    ),
                  ),
                  Text(
                    "${model.name}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: "Andika",
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: TextController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "What\s on your mind ?",
                    ),
                  ),
                ),
              ),
              if (cubit.PostImage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        ConditionalBuilder(
                          condition: state is SaveProfileToServerSuccessState ||
                              state is SaveCoverToServerSuccessState ||
                              state is UserDataSuccessState,
                          builder: (context) => Image(
                            image: FileImage(cubit.PostImage!),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          fallback: (context) => Image(
                            image: FileImage(cubit.PostImage!),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            radius: 17,
                            child: IconButton(
                              onPressed: () {
                                cubit.ClosePostImage();
                              },
                              icon: Icon(
                                Icons.close,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    direction: Axis.horizontal,
                    children: [
                      Container(
                        child: TextButton(
                          onPressed: () {
                            cubit.UploadePostImage();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                IconlyBroken.image,
                              ),
                              Text("Photo"),
                            ],
                          ),
                        ),
                        width: 120,
                      ),
                      Container(
                        width: 120,
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("# Tags"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      listener: (context, state) {
        var cubit = SocialLayOutCubit.get(context);
        if (state is CreatePostSuccessState) {
          cubit.PostImage = null;

        }
      },
    );
  }
}
