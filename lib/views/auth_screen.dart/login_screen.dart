import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_order/consts/consts.dart';
import 'package:my_order/views/auth_screen.dart/signup_screen.dart';
import 'package:my_order/views/controller/auth_controller.dart';
import 'package:my_order/views/home_screen/home.dart';
import 'package:my_order/widgets_comman/applogo_widget.dart';
import 'package:my_order/widgets_comman/bg_widget.dart';
import 'package:my_order/widgets_comman/custom_textfield.dart';
import 'package:my_order/widgets_comman/our_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}): super(key:key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
      child: Scaffold(
        body: SingleChildScrollView( // Wrap with SingleChildScrollView
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  applogoWidget(),
                 const SizedBox(height: 10),
                const  Text(
                    "Log in to $appname",
                    style: TextStyle(
                      fontFamily: bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
               const   SizedBox(height: 10),
            Obx(()=>
                Column(
                    children: [
                      customTextField(
                        hint: emailHint,
                        title: email,
                        isPass: false,
                        controller: controller.emailController,
                      ),
                      customTextField(
                        hint: passwordHint,
                        title: password,
                        isPass: true,
                        controller: controller.passwordController,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                         
                          },
                          child: forgetPass.text.make(),
                        ),
                      ),
                 const     SizedBox(height: 5),
              controller.isLoading.value ? const CircularProgressIndicator(
                valueColor:AlwaysStoppedAnimation(redColor) ,
              ):  ourButton(
                        color: redColor,
                        title: login,
                        textColor: whiteColor,
                        onPress: () async {
                             controller.isLoading(true);
                            await controller.loginMethod(context: context).then((value) {
                              if(value != null) {
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(() => const Home());
                              }
                              else{
                                  controller.isLoading(false);
                              }
                            });
                        
                        },
                      ).box.width(context.screenWidth - 50).make(),
                   const   SizedBox(height: 5),
                      createNewAccount.text.color(fontGrey).make(),
                  const    SizedBox(height: 5),
                      ourButton(
                        color: lightGolden,
                        title: signup,
                        textColor: redColor,
                        onPress: () {
                          Get.to(() => const SignUpScreen());
                        },
                      ).box.width(context.screenWidth - 50).make(),
                  const    SizedBox(height: 10),
                      loginWith.text.color(fontGrey).make(),
                   const   SizedBox(height: 5),
                    ],
                  ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).make(),
               )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
