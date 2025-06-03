import 'package:flutter/material.dart';
import 'package:projectwithnode/controllers/auth_controller.dart';
import 'package:projectwithnode/views/screens/details/screens/order_screen.dart';

class AccountScreen extends StatelessWidget {
   AccountScreen({super.key});
  final _authController=AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: ()async{
          Navigator.push(context,MaterialPageRoute(builder: (context){
            return OrderScreen();

          }));
        }, child: Text('My Orders')),
      ),
    );
  }
}