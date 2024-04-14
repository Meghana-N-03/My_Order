import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_order/consts/colors.dart';
import 'package:my_order/consts/consts.dart';
import 'package:my_order/consts/lists.dart';
import 'package:my_order/services/firebase_services.dart';
import 'package:my_order/views/category_screen/item_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(12),

      color:lightGrey,
      width:context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(child: Column(children:
       [
        Container(
          alignment: Alignment.center,
          height: 60,
          
          color:lightGrey,
          child: TextFormField(decoration: const InputDecoration(
            filled: true,
            border: InputBorder.none,
            suffixIcon:Icon(Icons.search) ,
            fillColor: whiteColor,
            hintText: searchanything,
            hintStyle: TextStyle(
              color:textfieldGrey
            )
          ),),
        ),
10.heightBox,
Expanded( 
child:SingleChildScrollView(
  physics: const BouncingScrollPhysics(),
child: Column(
children: [
          VxSwiper.builder(
          aspectRatio: 16/9,
          autoPlay: true,
          enlargeCenterPage: true,
          height:150 ,
        
          itemCount:sliderList.length,
          itemBuilder:(context, index)

        {
          return Image.asset(sliderList[index],
            fit:BoxFit.fitWidth,
            
            
          ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();

        } ),

        20.heightBox,
      //  Align(alignment: Alignment.centerLeft,
      //  child: allproducts.text.fontFamily(bold).color(darkFontGrey).size(18).make(),
      //  )
        StreamBuilder(stream: FirestoreServices.allProducts(),

        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot )
        {
        if(!snapshot.hasData)
        {
          return const Center(
    child: CircularProgressIndicator(
                valueColor:AlwaysStoppedAnimation(redColor) ,)
  );
        }
        else{
          var  allproductsdata=snapshot.data!.docs;
          
          return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: allproductsdata.length,
         
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 350),
            itemBuilder:(context,index)
            {
              return Column(
                
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
          Image.network(
            allproductsdata[index]['p_imgs'][0],
            height: 200,
            width: 200,
            fit:BoxFit.cover,
          ),
          const Spacer(),
        "${allproductsdata[index]['p_name']}" .text.fontFamily(semibold).color(darkFontGrey).make(),
          10.heightBox,
          "${allproductsdata[index]['p_price']}".text.color(redColor).fontFamily(bold).size(16).make(),
          10.heightBox,



         ],
              ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(12)).make()
              .onTap(() {
                Get.to(()=>ItemDetails(title: "${allproductsdata[index]['p_name']}",
                data:allproductsdata[index])
        );
              });
            }
            );
        }
        }
        
        )
        ],
 ),
),
),
],
    
        )),
    );

  }
}