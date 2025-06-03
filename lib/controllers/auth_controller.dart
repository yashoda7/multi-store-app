// import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projectwithnode/global_variables.dart';
import 'package:projectwithnode/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:projectwithnode/providers/user_provider.dart';
import 'package:projectwithnode/services/manage_http_response.dart';
import 'package:projectwithnode/views/screens/authentication_screens/login_screen.dart';
import 'package:projectwithnode/views/screens/main_screen.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projectwithnode/providers/user_provider.dart';
final providerContainer=ProviderContainer();
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
       manageHttpResponse(response: response, context: context, 
       onSucess: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) =>
          LoginScreen(),
        ));
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
    manageHttpResponse(response: response, context: context, 
    onSucess: () async{
      //access sharedprefernec for token and user data storage
      SharedPreferences preferences=await SharedPreferences.getInstance();
      String token=jsonDecode(response.body)['token'];
      await preferences.setString('auth-token', token);
      //encode the user data received from backend as json
     final userJson= jsonEncode(jsonDecode(response.body)['user']);
     providerContainer.read(useprovider.notifier).setUser(userJson);
     preferences.setString("user", userJson);
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=> MainScreen()),(route)=> false);
      showSnackBar(context, "logined Sucessfully");
    });
  }
  catch(e){
    showSnackBar(context,e.toString());
  }
}
// signout
Future<void> signOutUser({required context})async{
  try{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    await sharedPreferences.remove('auth-token');
    await sharedPreferences.remove('uset');
    providerContainer.read(useprovider.notifier).signout();
    //navigate user to login screen;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginScreen()),(route) => false);
      showSnackBar(context,'signout sucessfully');
}
  catch(e){
    showSnackBar(context,"error signing out");
  }

  }
  // Update User state city and locality
  
  Future<void> updateUserLocation({
    required context,
    required String id,
    required String state,
    required String city,
    required String locality
  }) async {
    try{
     // make http put eqqquest to update
     final http.Response response =await http.put(Uri.parse("$url/api/users/$id"),
     // headers is used to specify that content is type of json
      headers: <String,String>{
      'Content-Type':"application/json; charset=UTF-8",
    },

      body: jsonEncode(
        {
          "state":state,
          "city":city,
          "locality":locality,

        }
      )
     );
     manageHttpResponse(response: response, context: context, 
     onSucess: () async{
      //decoded the updated data so the json data is converted into dart map
      final updatedUser =jsonDecode(response.body);
      // Acess shared prefernce  for local data storage
      // shared prefernce allow  us to store data  persisintely  on the device 
      SharedPreferences preferences=await SharedPreferences.getInstance();
      final userJson=jsonEncode(updatedUser);
      // ProviderContainer.read(useprovider.notifier).setUser(userJson);
      final container = ProviderContainer();
      container.read(useprovider.notifier).setUser(userJson);
   await preferences.setString('user', userJson);



      
     });

    }
    catch(e){

      showSnackBar(context, "Error updating Location");
    }
  }
}

