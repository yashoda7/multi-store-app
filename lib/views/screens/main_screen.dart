import 'package:flutter/material.dart';
import 'package:projectwithnode/views/screens/nav_screens/account_screen.dart';
import 'package:projectwithnode/views/screens/nav_screens/cart_screen.dart';
import 'package:projectwithnode/views/screens/nav_screens/category_screen.dart';
import 'package:projectwithnode/views/screens/nav_screens/favourite_screen.dart';
import 'package:projectwithnode/views/screens/nav_screens/home_screen.dart';
import 'package:projectwithnode/views/screens/nav_screens/store_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  //  final int _pageindex=0;
  

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
     int _pageindex=0;
     final List<Widget> pages=[
      HomeScreen(),
      FavouriteScreen(),
      CategoryScreen(),
      StoreScreen(),
      CartScreen(),
      AccountScreen(),
     ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageindex,
        onTap: (value){
          setState(() {
            _pageindex=value;
          });
        },
        items: [
        BottomNavigationBarItem(icon: Image.asset("assets/icons/home.png",width:25),label: "Home"),
        BottomNavigationBarItem(icon: Image.asset("assets/icons/love.png",width:25),label: "favourite"),
        BottomNavigationBarItem(icon: Icon(Icons.category),label: "category"),
        BottomNavigationBarItem(icon: Image.asset("assets/icons/mart.png",width:25),label: "Stores"),
        BottomNavigationBarItem(icon: Image.asset("assets/icons/cart.png",width:25),label: "Cart"),
        BottomNavigationBarItem(icon: Image.asset("assets/icons/user.png",width:25),label: "Account"),

      ],),
      body: pages[_pageindex],
    );
  }
}