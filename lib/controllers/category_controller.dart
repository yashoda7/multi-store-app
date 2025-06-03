import 'dart:convert';
import 'package:projectwithnode/services/manage_http_response.dart';
import 'package:http/http.dart' as http;
import 'package:projectwithnode/models/category.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:projectwithnode/global_variable.dart';

class Categorycontroller {
  uploadCategory ({
    required dynamic pickedImage,required dynamic pickedBanner,
    required String name,required context
  }) async{
    try{
    // final cloudinary=CloudinaryPublic("", "");
    final cloudinary = CloudinaryPublic("du2msxzwq", "c7fvbrax");
    CloudinaryResponse ImageResponse=await cloudinary.uploadFile(
      CloudinaryFile.fromBytesData(pickedImage, identifier: "pickedImages",folder: "categoryImages"),
    );
    // print(ImageResponse);
   String image= ImageResponse.secureUrl;
    CloudinaryResponse BannerResponse=await cloudinary.uploadFile(
      CloudinaryFile.fromBytesData(pickedBanner, identifier: "pickedBanners",folder: "categoryImages"),
    );
    String banner=BannerResponse.secureUrl;
     Category category=Category(id: "", name: name, image: image, banner: banner);
    http.Response response=await http.post(Uri.parse("$uri/api/categories"),
     body:category.toJson(),
     headers: <String,String>{
      "Content-Type":"application/json; charset=UTF-8",
     } );
     manageHttpResponse(response: response, context: context, onSucess: (){
      showSnackBar(context,"Uploaded Category");
     });
    
    }
    catch(e){
      print("error while uploading the image $e");
    }
  }
    Future<List<Category>> loadCategories() async{
    try{
          http.Response response= await http.get(Uri.parse("$uri/api/categories"),
            headers: <String,String>{
          "Content-Type":"application/json; charset=UTF-8",
        });
        if(response.statusCode==200){
          List<dynamic> data=jsonDecode(response.body);
          // data.map(() => BannerModel.fromJson(banner)).toList();
          List<Category> categories=data.map((category) => Category.fromJson(category)).toList();
          return categories;
        }
        else{
          throw Exception("failed to load categories");
        }
        }
        catch(e){
          throw Exception("error loading categeroies $e");
        }
      }
  }