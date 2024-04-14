



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_order/consts/consts.dart';
import 'package:my_order/views/auth_screen.dart/login_screen.dart';



class AuthController extends GetxController
{

var isLoading=false.obs;

  //textcontrollers
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  Future<UserCredential?> loginMethod({context}) async
  {
    UserCredential? userCredential;
    try{
userCredential=await  auth.signInWithEmailAndPassword(email:emailController.text,password: passwordController.text);

    }on FirebaseAuthException  catch(e)
    {
VxToast.show(context,msg:e.toString());
    }
    return userCredential;
  }




Future<UserCredential?> signupMethod({email,password,context}) async
  {
    UserCredential? userCredential;
    try{
userCredential=await  auth.createUserWithEmailAndPassword(email:email,password: password);

    }on FirebaseAuthException  catch(e)
    {
VxToast.show(context,msg:e.toString());
    }
    return userCredential;
  }

//storing data method

storeUserData({name,password,email}) async{
  DocumentReference store= firestore.collection(usersCollection).doc(currentUser!.uid);
  store.set({
    'name':name,
    'password':password,
    'email':email,
   
    'id':currentUser!.uid,
    "cart_count":"00",
    "order_count":"00"
  });
}

//signout
signOutMethod(context) async
{
  try {
    await auth.signOut();
    // Clear any stored authentication tokens or credentials here
    // For example:
    // auth.currentUser = null;
    // tokenManager.clearToken();

    // Navigate to the LoginScreen
    // Get.offAll(() => const LoginScreen());
    Navigator.popUntil(context, ModalRoute.withName("/"));
  } catch(e) {
    VxToast.show(context,msg:e.toString());
  }
}



}