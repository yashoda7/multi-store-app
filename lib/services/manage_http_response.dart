import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
// this function is useful to handle http requests regarding its status code
void manageHttpResponse({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSucess,
}){
    switch(response.statusCode) {
      case 200: onSucess();
            break;
      case 400: showSnackBar(context,json.decode(response.body)['msg']);
          break;
      case 500:showSnackBar(context,json.decode(response.body)['msg']);
        break;
      case 201:onSucess();
        break;
    }
}
 void showSnackBar(BuildContext context,String title){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
 }