

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:my_order/consts/consts.dart';
import 'package:my_order/services/firebase_services.dart';
import 'package:my_order/views/cart_screen/shipping_screen.dart';
import 'package:my_order/views/controller/cart_controller.dart';
import 'package:my_order/widgets_comman/our_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(CartController());
    return Scaffold(
backgroundColor: whiteColor,
      bottomNavigationBar:  SizedBox(

height: 60,
child: ourButton(
  color: redColor,
  onPress: (){


 Get.to(()=>const ShippingDetails());
  },
  textColor: whiteColor,
  title: "Proceed to shipping",
),
          ) ,
      


appBar: AppBar(
  automaticallyImplyLeading: false,
  title: "Shopping cart"
  .text
  .color(darkFontGrey)
  .fontFamily(semibold)
  .make(),
),

body: 

StreamBuilder(stream: FirestoreServices.getCart(currentUser!.uid),
 builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
 {
  if(!snapshot.hasData)
 {
  return  const Center(
    child: CircularProgressIndicator(
                valueColor:AlwaysStoppedAnimation(redColor) ,)
  );
 }
 else if(snapshot.data!.docs.isEmpty)
 {
return Center(
  child:"Cart is Empty".text.color(darkFontGrey).make(),
);
 }
 else {


  var data=snapshot.data!.docs;

  controller.calculate(data);

controller.productSnapshot=data;

  return Padding(
  padding: const EdgeInsets.all(8.0),
  child: Column(
    children: [
      Expanded(


       
          
          
       child: ListView.builder(
itemCount: data.length,
itemBuilder:(BuildContext context,int index)
{
  return ListTile(
leading: Image.network(
  "${data[index]['img']}",
width: 80,
fit: BoxFit.cover,

),
  title:"${data[index]['title']} x${data[index]['qty']}".text
  .fontFamily(semibold)
  .size(16)
  .make(),
  subtitle:"${data[index]['tprice']}".numCurrency.text.color(redColor).fontFamily(semibold).make() ,


  trailing: const Icon(Icons.delete,
  color: redColor,
  ).onTap(() {
    

FirestoreServices.deleteDocumment(data[index].id); 

  }),
  );
} ,

       ),
          
          
          
          
          
       

      ),
      Obx(() =>
   Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      "Total Price".text.fontFamily(semibold).color(darkFontGrey).make(),

     
           "${controller.totalp.value}".numCurrency.text.fontFamily(semibold).color(redColor).make(),


          
       

    ],

      )).box.padding( const EdgeInsets.all(12)).width(context.screenWidth-60 ).color(lightGolden).roundedSM.make(),
     10.heightBox,
//       SizedBox(
// width: context.screenWidth-60,
// child: ourButton(
//   color: redColor,
//   onPress: (){



//   },
//   textColor: whiteColor,
//   title: "Proceed to shipping",
// ),
//           ) 




    ],
  ),
);

 }
  
 }



    )
    );
  }
}