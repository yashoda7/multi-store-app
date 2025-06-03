import 'dart:convert';
import 'package:projectwithnode/global_variable.dart';
import 'package:http/http.dart' as http;
import 'package:projectwithnode/models/subcategory.dart';
class SubcategoryController {
  Future<List<SubCategory>> getSubCategoriesByCategoryName(String categoryName) async{
    try{
     http.Response response=await http.get(Uri.parse("$uri/api/category/$categoryName/subcategories"),
      headers: <String,String>{
      "Content-Type":"application/json; charset=UTF-8",}
      );
      if(response.statusCode==200){
        final List<dynamic> data=jsonDecode(response.body);
        if(data.isNotEmpty){
          return data.map((subcategory) => SubCategory.fromJson(subcategory)).toList();
        }
        else{
          print("unable to load subcategories");
        return [];
        }

      }
      else{
        print("unable to load subcategories");
        return [];
      }


    }
    catch(e){
      print("unable to load subcategories");
        return [];
    }

  }
}