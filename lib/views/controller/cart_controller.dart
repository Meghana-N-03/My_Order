import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_order/consts/consts.dart';
import 'package:my_order/consts/firebase_const.dart';
// import 'package:my_order/services/firebase_services.dart';
import 'package:my_order/views/controller/home_controller.dart';

class CartController extends GetxController{
  var totalp=0.obs;
  //shipping controller

  var addressController=TextEditingController();
  
  var cityController=TextEditingController();
  
  var stateController=TextEditingController();
  
  var postalcodeController=TextEditingController();
  
  var phoneController=TextEditingController();
  var  paymentIndex=0.obs;
late dynamic productSnapshot;

var products=[];
var placingOrder=false.obs;

  calculate(data)
  {
  
    for(var i=0;i<data.length;i++)
    {
      totalp.value=totalp.value + int.parse(data[i]['tprice'].toString());

    }
  }
  changePaymentIndex(index)
  {
    paymentIndex.value=index;
  }
getProductDetails()
{
  products.clear(); 
  for(var i=0;i<productSnapshot.length;i++)
  {
products.add(

  {
'img':productSnapshot[i]['img'],
'qty':productSnapshot[i]['qty'],
'title':productSnapshot[i]['title'],
'tprice':productSnapshot[i]['tprice'],
'vendor_id':productSnapshot[i]['vendor_id']



  }
);
  }
}







  placeMyOrder({required orderPaymentMethod,required totalAmount}) async
  {

    placingOrder(true);
    await getProductDetails();

// FirestoreServices.getOrder(orderPaymentMethod,totalAmount,addressController,stateController,cityController,postalcodeController,phoneController,products);
    await firestore.collection(ordersCollection).doc().set({
'order_code':"657584647",
'order_date':FieldValue.serverTimestamp(),
'order_by':currentUser!.uid,
'order_by_name':Get.find<HomeController>().username,
'order_by_email':currentUser!.email,
'order_by_address':addressController.text,
'order_by_state':stateController.text,
'order_by_city':cityController.text,
'order_by_postalcode':postalcodeController.text,
'order_by_phone':phoneController.text,
'shipping_method':"Home Delivery",
'payment_method':orderPaymentMethod,
'order_placed':true,
'Total Amount':totalAmount,
'orders': FieldValue.arrayUnion(products)


    }  );

    placingOrder(false);
  }



clearCart()
{
  for(var i=0;i<productSnapshot.length;i++)
  {firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();

  }
}
clearOrder()
{
  for(var i=0;i<=productSnapshot.length;i++)
  {
    firestore.collection(ordersCollection).doc(productSnapshot[i].id).delete();
  }
}


}
