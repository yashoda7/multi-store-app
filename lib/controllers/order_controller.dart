import 'dart:convert';

import 'package:projectwithnode/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:projectwithnode/global_variable.dart';
import 'package:projectwithnode/services/manage_http_response.dart';

class OrderController {
  //upload orders
  uploadOrders({
  required String id,
  required String fullName,
  required String email,
  required String state,
  required String city,
  required String locality,
  required String productName,
  required int productPrice,
  required int quantity,
  required String category,
  required String image,
  required String buyerId,
  required String vendorId,
  required bool processing,
  required bool delivered,
  required context,
   }) async{
    try{
      final Order order= Order(id: id, fullName: fullName, email: email, state: state, city: city, locality: locality, productName: productName, productPrice: productPrice, quantity: quantity, category: category, image: image, buyerId: buyerId, vendorId: vendorId, processing: processing, delivered: delivered);
     http.Response response= await http.post(Uri.parse("$uri/api/orders"),
      body: order.toJson(),
      headers: <String,String>{
        "Content-Type":"application/json; charset=UTF-8",
      }
      );
      manageHttpResponse(response: response, context: context, onSucess: (){
          showSnackBar(context,"you have sucessfully placed order");
      });

    }
    catch(e){
      showSnackBar(context, "Unable to place order");
    }
  }
  // controlleer for fetching all  items based on buyerid
  Future<List<Order>> loadOrders({ required String buyerId})async{
    try{
       http.Response response=await http.get(Uri.parse("$uri/api/orders/$buyerId"),
      headers: <String,String>{
        "Content-Type":"application/json; charset=UTF-8",
      }
      );
      // check response code is 200 or not
      if(response.statusCode==200){
      List<dynamic> data=  jsonDecode(response.body);
      // convert into List<order>
      List<Order> orders=data.map((order) => Order.fromJson(order)).toList();
      return orders;

      }{
         throw Exception("Failed to load ");
      }
      // throw Exception("Failed to load ")
      // return
    }
    catch(e){
      throw Exception("Failed to load ");
    }
  }
}