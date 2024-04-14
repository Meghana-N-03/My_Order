// import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_order/firebase_options.dart';
import 'package:my_order/views/splash_screen/splash_screen.dart';
import 'package:get/get.dart';
import 'consts/consts.dart';

void main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
    debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
            scaffoldBackgroundColor:Colors.transparent,
            appBarTheme:const AppBarTheme(
              backgroundColor: Colors.transparent),
             fontFamily: regular,
      ),
  home:const SplashScreen(),

    );
  } 
}