// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

import 'package:my_order/consts/consts.dart';
// import 'package:my_order/views/controller/home_controller.dart';
// import 'package:my_order/models/category_model.dart';

class FirestoreServices
{
  static getuser(uid)

  {
    return firestore.collection(usersCollection).where('id',isEqualTo: uid).snapshots();
  }

  static getProducts(category)
  {
    return firestore.collection(productsCollection).where('p_category',isEqualTo: category).snapshots();
  }

  //getcart


  static getCart(uid)
  {
    return firestore.collection(cartCollection).where('added_by',isEqualTo: uid).snapshots();
  }

  static deleteDocumment(docid)
  {
    return firestore.collection(cartCollection).doc(docid).delete();
  }

static getOrders()
{
  return firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).snapshots();
}

static getCounts() async
{
  var res= await Future.wait(
   [ firestore.collection(cartCollection).where('added_by',isEqualTo: currentUser!.uid).get().then((value)
  
{return value.docs.length;}
   ),

   firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).get().then((value)
  
{return value.docs.length;}
   )
   ]
  );
  return res;  
  }
  

  static allProducts()
  {
   return firestore.collection(productsCollection).snapshots();
  }
}
