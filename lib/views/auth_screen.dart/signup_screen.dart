import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:my_order/consts/consts.dart';
import 'package:my_order/views/controller/auth_controller.dart';
import 'package:my_order/views/home_screen/home.dart';
import 'package:my_order/widgets_comman/applogo_widget.dart';
import 'package:my_order/widgets_comman/bg_widget.dart';
import 'package:my_order/widgets_comman/custom_textfield.dart';
import 'package:my_order/widgets_comman/our_button.dart';




class SignUpScreen extends StatefulWidget {
  
  const SignUpScreen({Key? key}): super(key:key);

  @override
  State<SignUpScreen> createState()=>_SignupScreenState();
}

class _SignupScreenState extends State<SignUpScreen> {
  bool? isCheck=false;
  var controller=Get.put(AuthController());  

  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var passwordRetypeController=TextEditingController();

  @override
  Widget build(BuildContext context) {
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
               const  SizedBox(height: 10),
                 const Text(
                    "Join the $appname",
                    style: TextStyle(
                      fontFamily: bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
              const    SizedBox(height: 10),
              Obx(() => 
                  Column(
                    children: [
                      customTextField(hint:nameHint,title:name,controller:nameController,isPass:false),
                      customTextField(hint:emailHint,title:email,controller: emailController,isPass: false),
                      customTextField(hint:passwordHint,title:password,controller: passwordController,isPass: true),
                      customTextField(hint:passwordHint,title:retypePassword,controller: passwordRetypeController,isPass: true),
                      Align(
                        alignment:Alignment.centerRight,
                        child: TextButton(
                          onPressed: (){},
                          child: forgetPass.text.make(),
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            checkColor: redColor,
                            value: isCheck,
                            onChanged: (newValue) {
                              setState(() {
                                isCheck = newValue;
                              });
                            },
                          ),
                       const   SizedBox(width: 5),
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(
                                      fontFamily: bold,
                                      color: fontGrey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: termsAndCond,
                                    style: TextStyle(
                                      fontFamily: bold,
                                      color: redColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: privacyPolicy,
                                    style: TextStyle(
                                      fontFamily: bold,
                                      color: redColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                     const SizedBox(height: 5),
                     controller.isLoading.value? const CircularProgressIndicator(
                valueColor:AlwaysStoppedAnimation(redColor) ,
              ):
                      ourButton(
                        color: isCheck == true ? redColor : lightGrey,
                        title: signup,
                        textColor: whiteColor,
                        onPress: () async {
                          if(isCheck != false) {
                            controller.isLoading(true);
                            try {
                              await controller.signupMethod(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text
                              ).then((value) {
                                return controller.storeUserData(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text
                                );
                              }).then((value) {
                                VxToast.show(context, msg: loggedin); 
                                Get.offAll(() => const Home());
                              });
                            } catch(e) {
                              auth.signOut();
                              VxToast.show(context, msg: e.toString());
                              controller.isLoading(false);
                            }
                          }
                        },
                      ).box.width(MediaQuery.of(context).size.width - 50).make(),
                     const  SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          alreadyHaveAccount.text.color(fontGrey).make(),
                          login.text.color(redColor).make().onTap(() {
                            Get.back();
                          }),
                        ],
                      ),
                    ],
                  ).box.white.rounded.padding(const EdgeInsets.all(16)).width(MediaQuery.of(context).size.width - 70).make(),
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
