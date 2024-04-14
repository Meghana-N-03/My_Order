
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_order/consts/consts.dart';
import 'package:my_order/consts/lists.dart';
import 'package:my_order/views/controller/cart_controller.dart';
import 'package:my_order/views/home_screen/home.dart';
import 'package:my_order/widgets_comman/our_button.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {

var controller=Get.find<CartController>();
    return Obx(() => 
    
     Scaffold(
           backgroundColor:whiteColor,
            bottomNavigationBar:SizedBox(
          height: 60,

       child: controller.placingOrder.value?
 const Center(
    child: CircularProgressIndicator(
                valueColor:AlwaysStoppedAnimation(redColor) ,)
  )
      : ourButton(
          onPress: () async
          {

          await controller.placeMyOrder(orderPaymentMethod: paymentMethods[controller.paymentIndex.value], totalAmount: controller.totalp.value);
           

           await controller.clearCart();
           VxToast.show(context,msg:"Order placed Successfully");
           Get.offAll(const Home());
          },
          color: redColor,
          textColor: whiteColor,
          title: "Place my Order",

        ) ,
    ),

      appBar: AppBar(
        
        title: "Choose  a payment method".text.fontFamily(semibold).color(darkFontGrey).make(),
        
        
        ),

        body:
        Padding(padding: const EdgeInsets.all(8.0),
    child:    Obx(() => 
       Column(
          children: List.generate(paymentMethodsList.length, (index) 
          {
            return GestureDetector(
              onTap: () {
controller.changePaymentIndex(index);
              },
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(12),
                border: Border.all(
                 
color: controller.paymentIndex.value==index? redColor:Colors.transparent,
width: 4,

                ),
                
              ),

              margin: const EdgeInsets.only(bottom: 8),
              child: Stack
              (
                alignment: Alignment.topRight,
             children:[ 
              Image.asset(paymentMethodsList[index],
              width: double.infinity,
              height: 120,
              colorBlendMode: controller.paymentIndex.value==index? BlendMode.darken :BlendMode.color,
              color:controller.paymentIndex.value==index?  Colors.black.withOpacity(0.4):Colors.transparent,

              fit: BoxFit.cover,),
              controller.paymentIndex.value==index?
              Checkbox(
                activeColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                ),

                value:true , onChanged: (value){})
                :Container(

                ),
Positioned(
  bottom: 0,
  right: 10,
child:paymentMethods[index].text.white.fontFamily(semibold).size(16).make()

)         
                
             ],
              ),
            ));
          } )
        )),
        )
    )
    );
  }
}