import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_app/cubit/cubit.dart';
import 'package:socialapp/layout/social_app/social_layout.dart';
import 'package:socialapp/shared/components/constants.dart';
import 'package:socialapp/shared/network/local/bloc_observer.dart';
import 'package:socialapp/shared/network/local/cashe_helper.dart';
import 'package:firebase_core/firebase_core.dart';

import 'modules/Social_login/Shop_LogIn.dart';
import 'modules/Social_login/cubit/cubit.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.Init();
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.notification?.body.toString());
  });




  await Firebase.initializeApp(
// options: FirebaseOptions(apiKey: "AIzaSyDKJ7q0XYOadQuypGVeeibx79c-og7ySJ0", appId: "1:801890669392:web:ae31348bde25c9f7841255", messagingSenderId: "801890669392", projectId: "social-app-a2823")


    //name: 'Viewo - Test Sunny',
  );

  UserId = await CacheHelper.GetData("uid");
  print(UserId);
  if (UserId != null) {
    BaseScreen = SocialLayout();
  } else {
    BaseScreen = ShopLogInScreen();
  }

  runApp(MyApp(BaseScreen));
}

class MyApp extends StatelessWidget {
  Widget? baseScreen;

  MyApp(this.baseScreen);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialLoginCubit(),
        ),
        BlocProvider(
          create: (context) => SocialLayOutCubit()
            ..GettUser()
            ..GetPosts()..GetNumberOfPosts(),
        ),
      ],
      child: MaterialApp(
        title: 'Social App',
        debugShowCheckedModeBanner: false,
        theme: LightTheme,
        darkTheme: DarkTheme,
        themeMode: ThemeMode.light,
        home: baseScreen,
      ),
    );
  }
}
