
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:my_order/consts/consts.dart';
import 'package:my_order/views/cart_screen/payment_method.dart';
import 'package:my_order/views/controller/cart_controller.dart';
import 'package:my_order/widgets_comman/custom_textfield.dart';
import 'package:my_order/widgets_comman/our_button.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});
  

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
      
        title: "Shipping Info".text.fontFamily(semibold).color(darkFontGrey).make(),

        
        
        ),
        bottomNavigationBar:SizedBox(
          height: 60,

       child: ourButton(
          onPress: ()
          {
if(controller.addressController.text.length  >10 )

{
Get.to(()=> const PaymentMethods());

}
else{
  VxToast.show(context,msg:"Please fill the form");
}
           
          },
          color: redColor,
          textColor: whiteColor,
          title: "Continue",

        ) ,
    ),


    body:Padding
    (padding: const EdgeInsets.all(12.0),
    
  child:  Column(
      children: [

        customTextField(hint: "Address",isPass: false,title:"Address",controller: controller.addressController),
        customTextField(hint: "City",isPass: false,title:"city",controller: controller.cityController),
        customTextField(hint: "State",isPass: false,title:"state",controller: controller.stateController),
        customTextField(hint: "Postal Code",isPass: false,title: "postal code",controller: controller.postalcodeController),
        customTextField(hint: "Phone",isPass: false,title: "phone",controller: controller.phoneController),
      ],

    ) ,
     ) );
  }
}