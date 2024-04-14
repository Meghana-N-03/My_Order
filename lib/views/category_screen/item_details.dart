import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_order/consts/colors.dart';
import 'package:my_order/consts/consts.dart';
import 'package:my_order/views/controller/product_controller.dart';
import 'package:my_order/widgets_comman/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemDetails extends StatelessWidget {

  final String? title;
  final dynamic data;
    const ItemDetails({Key?key,required this.title,this.data}):super(key:key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ProductController());
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(

        leading: IconButton(
          onPressed: (){
            controller.resetValues();
            Get.back();
          },
          
          icon: const Icon(Icons.arrow_back),),

title: title!.text.color(darkFontGrey).fontFamily(bold).make(),


        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.share,color: darkFontGrey,)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_outline,color: darkFontGrey,))
        ],
      ),
body:Column(

  children: [
    Expanded(child: 
    Padding(
    padding:const EdgeInsets.all(8),
    child: SingleChildScrollView(
      child: 
    Column(
      crossAxisAlignment: CrossAxisAlignment.start ,
      children: [
        VxSwiper.builder(
          autoPlay: true,
          height: 350,
          
          aspectRatio: 16/9,
          
          viewportFraction: 1.0,
          itemCount:data['p_imgs'].length,
          itemBuilder: (context,index) {
          return Image.network(data['p_imgs'][index],
          width:double.infinity,
          fit:BoxFit.cover)
          ;
        },),
        10.heightBox,
        title!.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
        10.heightBox,
        VxRating(
          value: double.parse(data['p_rating']),
          
          onRatingUpdate: (value){},normalColor: textfieldGrey,selectionColor: golden,
        count: 5,
        maxRating: 5,
        size:25,
       ), 
        10.heightBox,
        "${data['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(18).make(),
        10.heightBox,
      Row(

          children: [
       Expanded(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "${data['p_seller']}".text.white.fontFamily(semibold).make(),
          5.heightBox,
   


        ],  
       )
       ),
     const  CircleAvatar(
          backgroundColor:Colors.white ,
          child: Icon(
            Icons.message_rounded,color:darkFontGrey
          ),
        )

           ,
        ],).box.height(60).padding( const EdgeInsets.symmetric(horizontal: 16)).color(textfieldGrey).make(),


20.heightBox,




//quantity
Row(
      children: [
        SizedBox(
          width: 100,
          child:"Quantity".text.color(textfieldGrey).make(),
        ),
        Obx(() =>
       Row(

        children: [
        IconButton(onPressed: (){
controller.decreaseQuantity();
controller.calculateTotalPrice(int.parse(data['p_price']));
        }, icon: const Icon(Icons.remove)),
        controller.quantity.value.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
         IconButton(onPressed: (){
controller.increaseQuantity(
  int.parse(data['p_quantity'])
);
controller.calculateTotalPrice(int.parse(data['p_price']));

         }, icon: const Icon(Icons.add)),
         10.widthBox,
         "(${data['p_quantity']} available)".text.color(textfieldGrey).make(),

        ],
        
        ),
        )
        
      ],
    ).box.padding(const EdgeInsets.all(8)).make(),
//total
 Obx(() => Row(
      children: [
        SizedBox(
          width: 100,
          child:"Total".text.color(textfieldGrey).make(),
        ),
     
        "${controller.totalPrice.value}".numCurrency.text.color(redColor).size(16).fontFamily(bold).make(),
      ],
    )).box.padding(const EdgeInsets.all(8)).make(),
     //description
     10.heightBox,
     "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
     10.heightBox,
     "${data['p_description']} ".text.color(darkFontGrey).make(),
      

      ],
    ),



    )



    )
),

SizedBox(
  width: double.infinity,
  height: 60,

  child: ourButton(
    color:redColor,
    onPress: (){

      if(controller.quantity.value >0)
      {
        controller.addToCart(
        context: context,
        vendorId: data['vendor_id'],
        img: data['p_imgs'][0],
        qty: controller.quantity.value,
        sellername: data['p_seller'],
        title: data['p_name'],
        tprice: controller.totalPrice.value

      );
      VxToast.show(context,msg:"Added to cart");
      }
      else
      {
        VxToast.show(context, msg:"Minimum 1 product is required");
      }
    },
    textColor: whiteColor,
    title: "Add to cart",



  ),
)




  ],
),
    );
  }
}
