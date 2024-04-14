import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_order/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:my_order/consts/consts.dart';
import 'package:my_order/views/auth_screen.dart/login_screen.dart';


import 'package:get/get.dart';
import 'package:my_order/views/home_screen/home.dart'; // Import Get package


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}): super(key:key);
// static String icSplashBg = 'assets/images/square_logo.png';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


changeScreen()
{
  Future.delayed( const Duration(seconds:3 ),() => {
    // Get.to(()=> const LoginScreen())
    auth.authStateChanges().listen((User? user) { 
      if(user==null && mounted)
      {
        Get.to(()=> const LoginScreen());

      }
      else{
          Get.to(()=> const Home());
      }
    })
  }
  
  );
}

@override
  void initState() {
 
    changeScreen();
    super.initState();
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
// Define icSplashBg


     body: Center(
        child: Column(
          children: [

           
          
             10.heightBox,
             appname.text.fontFamily(bold).size(22).white.make(),
             5.heightBox,
             appversion.text.white.make(),
             const Spacer(),
             credits.text.white.fontFamily(semibold).make(),
             30.heightBox,
              
          ],
           ),
    ),
    );
  }
}