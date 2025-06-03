import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projectwithnode/models/banner_model.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:projectwithnode/global_variable.dart';
import 'package:projectwithnode/services/manage_http_response.dart';
class Bannercontroller {
  Uploadbanner({
    required dynamic pickedImage,required context,
  })async{
    try{
     final cloudinary = CloudinaryPublic("du2msxzwq", "c7fvbrax");
    CloudinaryResponse ImageResponse=await cloudinary.uploadFile(
      CloudinaryFile.fromBytesData(pickedImage, identifier: "pickedImages",folder: "banners"));
      String image= await ImageResponse.secureUrl;
      BannerModel bannerModel=BannerModel(id: "", image: image);
      http.Response response=await http.post(Uri.parse("$uri/api/banner"),
      body: bannerModel.toJson(),
      headers: <String,String>{
        "Content-Type":"application/json; charset=UTF-8"
      });
      manageHttpResponse(response: response, context: context, onSucess: (){
      showSnackBar(context,"Banner Uploaded ");
     });
 
    }
    catch(e){
      print(e);
    }
  }
    Future<List<BannerModel>> loadBanners() async{
      try{
         http.Response response= await http.get(Uri.parse("$uri/api/banner"),
          headers: <String,String>{
        "Content-Type":"application/json; charset=UTF-8",
      });
      if(response.statusCode==200){
        List<dynamic> data=jsonDecode(response.body);
        // data.map(() => BannerModel.fromJson(banner)).toList();
        List<BannerModel> banners=data.map((banner) => BannerModel.fromJson(banner)).toList();
        return banners;
      }
      else{
        throw Exception("failed to load banners");
      }
      }
      catch(e){
        throw Exception("error loading Banners $e");
      }
    }
    
}