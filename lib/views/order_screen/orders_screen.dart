import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_order/consts/colors.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
import 'package:my_order/consts/consts.dart';
import 'package:my_order/services/firebase_services.dart';
import 'package:my_order/views/order_screen/order_details.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: whiteColor,
appBar: AppBar(

  title: "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
),


body:StreamBuilder(
  
  stream: FirestoreServices.getOrders(),
  
  builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
    if(!snapshot.hasData)
    {
return const Center(
    child: CircularProgressIndicator(
                valueColor:AlwaysStoppedAnimation(redColor) ,)
  );
    }
    else if(snapshot.data!.docs.isEmpty)
    {
return 
  "No orders yet".text.color(darkFontGrey).makeCentered();

    }
  else 
  {
var data=snapshot.data!.docs;




    return ListView.builder(

itemCount:data.length,
itemBuilder: (BuildContext context,int index)
{
  return ListTile(

leading: "${index+1}".text.fontFamily(bold).color(darkFontGrey).xl.make(),
   
    title:data[index]['order_code'].toString().text.color(redColor ).fontFamily(semibold).make(),
    subtitle: data[index]['Total Amount'].toString().numCurrency.text.color(darkFontGrey).fontFamily(bold).make(),
trailing: IconButton(onPressed: (){
      Get.to(() => OrderDetails(data: data[index],));
},icon: const Icon(Icons.arrow_forward_ios_rounded,color:darkFontGrey,),),

    );
},



      
    );
  }
  }
) ,
    );
 
  }
}