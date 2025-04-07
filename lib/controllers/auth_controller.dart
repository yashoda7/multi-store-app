// import 'dart:io';
import 'dart:convert';
import 'package:projectwithnode/global_variables.dart';
import 'package:projectwithnode/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:projectwithnode/services/manage_http_response.dart';
class AuthController {
  Future<void> SignUpUsers({
    required context,
    required String email,
    required String fullName,
    required String password,
  }) async{
    try{
     User user= User(id: '',
       fullName: fullName, 
       email: email, 
       state: '', 
       city: '',
        locality: '', 
        password: password,
        token: "");
      http.Response response =await http.post(Uri.parse("$url/api/signup"),
       body: user.toJson(),
       headers: <String,String> {
        'Content-Type':'application/json; charset=UTF-8',

       });
       manageHttpResponse(response: response, context: context, onSucess: (){
        showSnackBar(context,"account has been created sucesssfully");
       });// convert user object into json body
    }
    catch(e) {
  showSnackBar(context, e.toString());
}

  }
  //signin user function
Future<void> signInUser({
  required context,
  required String email,
  required String password,
}) async{
  try{
   http.Response response= await http.post(Uri.parse("$url/api/signin"),
    body: jsonEncode({
      "email":email,
      "password":password,
    }),
    headers: <String,String>{
      'Content-Type':"application/json; charset=UTF-8",
    }
    );
    //handle the response using managehttpresponse;
    manageHttpResponse(response: response, context: context, onSucess: (){
      showSnackBar(context, "logined Sucessfully");
    });
  }
  catch(e){
    showSnackBar(context,e.toString());
  }
}
}
