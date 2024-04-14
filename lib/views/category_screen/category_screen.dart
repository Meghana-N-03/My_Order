import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_order/consts/consts.dart';
import 'package:my_order/consts/lists.dart';
import 'package:my_order/views/category_screen/category_details.dart';
import 'package:my_order/views/controller/product_controller.dart';
import 'package:my_order/widgets_comman/bg_widget.dart';
// import 'package:my_order/views/auth_screen.dart/login_screen.dart';
// import 'package:my_order/views/controller/auth_controller.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ProductController());

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: categories.text.fontFamily(bold).white.make(),

          
          ),
          body: Container(
            padding:const EdgeInsets.all(12) ,
            
child: GridView.builder(
  
   shrinkWrap: true,
              itemCount: 5,
  gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 200), itemBuilder: (context,index){

return Column(


children: [
  Image.asset(categoriesImages[index],
  height: 120,
  width:200,
  fit:BoxFit.cover,

 
  ),
  10.heightBox,
  categoryList[index].text.color(darkFontGrey).align(TextAlign.center).make(),


// 80.heightBox,









],





).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {
 
controller.getSubCategories(categoryList[index]);

  Get.to(()=>CategoryDetails(title:categoryList[index])
  );
});


}),

            ),
      )
    );
  }
}