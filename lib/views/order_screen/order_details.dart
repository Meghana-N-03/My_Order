
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/widgets.dart';
import 'package:my_order/consts/consts.dart';
import 'package:my_order/views/order_screen/components/order_place_details.dart';
import 'package:intl/intl.dart' as intl;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'package:pdf/pdf.dart' as pdf; // Import pdf library with alias
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';



class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({Key? key,this.data}) :super(key:key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
backgroundColor: whiteColor,

      appBar: AppBar(
        title: "Order Details".text.fontFamily(semibold).make(),
      ),

      body:Padding(
        padding: const EdgeInsets.all(8.0),
    
child:SingleChildScrollView(
    physics:const BouncingScrollPhysics(),
        child:Column(
        children: [

          const Divider(),
          10.heightBox,

          Column(
            children: [
                       orderPlaceDetails(

d1: data['order_code'],
d2:data['shipping_method'],
title1: "Order Code",
title2: "Shipping Code"

         ),
       orderPlaceDetails(

d1:intl.DateFormat().add_yMd().format((data['order_date'].toDate())),
d2: data['payment_method'],
title1: "Order Date",
title2: "Payment Method"

         
 
       ),  
        orderPlaceDetails(

d1:"Unpaid",
d2: "Order Placed",
title1: "Payment Status",
title2: "Delivery Status"

         
 
       ),  
        orderPlaceDetails(

d1:intl.DateFormat().add_yMd().format((data['order_date'].toDate())),
d2: data['payment_method'],
title1: "Order Date",
title2: "Payment Method"

         
 
       ), 

Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              "Shipping Address".text.fontFamily(semibold).make(),
              "${data['order_by_name']}".text.make(),
              "${data['order_by_email']}".text.make(),
              "${data['order_by_address']}".text.make(),
              "${data['order_by_state']}".text.make(),
              "${data['order_by_postalcode']}".text.make(),
              "${data['order_by_phone']}".text.make(),
            ],
          ),
          SizedBox(
            width: 100,
        child:  Column(
mainAxisAlignment: MainAxisAlignment.start,
crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                "Total Amount".text.fontFamily(semibold).make(),
                "${data['Total Amount']}".text.color(redColor).fontFamily(semibold).make(),
            ],
          )
      )
        ],
       )  )
            ],
          ).box.outerShadowMd.white.make(),
       const   Divider(),
          10.heightBox,
          "Ordered Product".text.size(16).fontFamily(semibold).color(darkFontGrey).makeCentered(),
          10.heightBox,
     
ListView(
  physics: const NeverScrollableScrollPhysics(),
  shrinkWrap: true,
  children: 
       List.generate(data['orders'].length, (index){
          return orderPlaceDetails(

            title1: data['orders'][index]['title'],
            title2: data['orders'][index]['tprice'],
            d1:"qty: ${data['orders'][index]['qty']}",
            d2:"Refundable"


          );
        }).toList(),
).box.shadowMd.white.margin(const EdgeInsets.only(bottom: 4)).make(),
20.heightBox,
  ElevatedButton(
              onPressed: () => _saveAsPdf(context),
              child: const Text("Download PDF"),
            ),


      ],
      )
      ),
    ));
  }

  Future<void> _saveAsPdf(BuildContext context) async {
  final pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Add your order details to the PDF here
            // For example:
            _buildOrderDetails(
              title: "Order Code",
              value: data['order_code'],
            ),
            _buildOrderDetails(
              title: "Shipping Method",
              value: data['shipping_method'],
            ),
            _buildOrderDetails(
              title: "Order Date",
              value: intl.DateFormat().add_yMd().format((data['order_date'].toDate())),
            ),
            _buildOrderDetails(
              title: "Payment Method",
              value: data['payment_method'],
            ),
            _buildOrderDetails(
              title: "Total Amount",
              value: "${data['Total Amount']}",
            ),
            pw.SizedBox(height: 20),
            pw.Text("Ordered Products", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            // Add ordered products here
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: List.generate(
                data['orders'].length,
                (index) => _buildOrderDetails(
                  title: data['orders'][index]['title'],
                  value: "Qty: ${data['orders'][index]['qty']} - ${data['orders'][index]['tprice']}",
                ),
              ),
            ),
                
         
          ],
        );
      },
    ),
  );

  final bytes = await pdf.save();
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => bytes,
  );
}

  pw.Widget _buildOrderDetails({required String title, required String value}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(title),
        pw.Text(value),
      ],
    );
  }
}

