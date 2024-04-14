import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_order/consts/consts.dart';
import 'package:my_order/consts/lists.dart';
import 'package:my_order/services/firebase_services.dart';
import 'package:my_order/views/auth_screen.dart/login_screen.dart';
import 'package:my_order/views/controller/auth_controller.dart';
import 'package:my_order/views/order_screen/orders_screen.dart';
// import 'package:my_order/views/profile_screen/components/details.dart';
import 'package:my_order/widgets_comman/bg_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    return bgWidget(
      child:Scaffold(
        body:StreamBuilder(
          
          
          
          stream: FirestoreServices.getuser(currentUser!.uid), 
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
          {
          if(!snapshot.hasData || snapshot.data!.docs.isEmpty)
          {
            return const  Center(child:
          CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),)
             );
          }
          else{

var data=snapshot.data!.docs[0];


            return SafeArea(
          
      
          child:Column(
            
            
            children: [
              Padding
              (padding: const EdgeInsets.all(8.0),

//edit profile

 child: Align(
  alignment: Alignment.topRight,
  child: const Icon(Icons.edit,color: whiteColor,).onTap(() {
    
  }),

),
              ),

//user details
Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child:    Row(
              children: [
                Image.asset(
                  imgProfile2,width: 100,
                  fit: BoxFit.cover,
                ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
                Expanded(child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    "${data['name']}".text.fontFamily(semibold).white.make(),
                
                  "${data['email']}" .text.white.make(),
                  ],
                )

                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: whiteColor,
                    )
                  ),
                  
                    onPressed: () async{
await Get.put(AuthController()).signOutMethod(context);
// Get.offAll(()=> const LoginScreen());

                    }, child:logout.text.fontFamily(semibold).white.make() ),


              ],




            ),
),




10.heightBox,
// FutureBuilder(
//   future: FirestoreServices.getCounts(),
//  builder: (BuildContext context,AsyncSnapshot snapshot) {
//   if(!snapshot.hasData)
//   {
//     return const Center(
//     child: CircularProgressIndicator(
//                 valueColor:AlwaysStoppedAnimation(redColor) ,)
//   );
//   }
//   else{
//     var countdata=snapshot.data;
//     return 
// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,

//   children: [
//     detailsCard(count:countdata[0].toString(),title:"in your cart",width:context.screenWidth/3.4),
//         detailsCard(count:countdata[1].toString(),title:"Your Order",width:context.screenWidth/3.4),
  
//   ],
// );

//   }
  
//  }
// ),





ListView.separated(
  shrinkWrap: true,
  separatorBuilder: (context,index)
  {
    return const  Divider(color:lightGrey ,);
  },
  itemBuilder:(BuildContext context,int  index) 
  {
    return ListTile(

      onTap:() => {
      Get.to(()=>const OrderScreen()),
      } ,
      leading:Image.asset(profileButtonsIcons[index],width: 22,),
      title:profileButtonsList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
      
    );
  } ,
    itemCount: profileButtonsList.length
    ).box.white.rounded.margin(const EdgeInsets.all(12)).padding(const EdgeInsets.symmetric(horizontal: 16)).shadowSm.make().box.color(redColor).make(),
          ],)

        );
          }}
      )

  
  )
    );
    
    
    

  }








  }
