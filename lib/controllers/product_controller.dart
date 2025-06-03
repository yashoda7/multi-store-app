import 'package:projectwithnode/global_variable.dart';
import 'package:projectwithnode/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:projectwithnode/services/manage_http_response.dart';
import 'dart:convert';
class ProductController {
  Future<List<Product>> loadPopularProducts() async {
  try {
    final response = await http.get(
      Uri.parse("$uri/api/popular-products"),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      // Check if it's a List or a Map
      if (decoded is List) {
        return decoded.map((item) => Product.fromMap(item)).toList();
      } else if (decoded is Map && decoded.containsKey('products')) {
        return (decoded['products'] as List)
            .map((item) => Product.fromMap(item))
            .toList();
      } else {
        throw Exception("Unexpected response format");
      }
    } else {
      throw Exception("Failed to load popular products");
    }
  } catch (e) {
    print("Exception occurred: $e");
    rethrow; 
  }
}
Future<List<Product>> loadProductsByCategory(String category) async{
  try{
    http.Response response=await http.get(Uri.parse("$uri/api/products-by-category/${category}"),
    headers: <String,String>{
      "Content-Type":"application/json; charset=UTF-8",
      }
    );

    if(response.statusCode==200){
      List<dynamic> data=jsonDecode(response.body) as List<dynamic>;
    final products=data.map((product)=>Product.fromMap(product as Map<String,dynamic>)).toList();
    return products;
    }
    else{
      throw Exception("fail to load produts");
    }
  }
  catch(e){
throw Exception("error:${e.toString()}");
  }

}

}