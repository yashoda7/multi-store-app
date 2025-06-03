import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:projectwithnode/models/category.dart';
import 'package:projectwithnode/views/screens/details/screens/widgets/inner_category_content_widget.dart';
import 'package:projectwithnode/views/screens/nav_screens/account_screen.dart';
import 'package:projectwithnode/views/screens/nav_screens/cart_screen.dart';
import 'package:projectwithnode/views/screens/nav_screens/category_screen.dart';
import 'package:projectwithnode/views/screens/nav_screens/favourite_screen.dart';
// import 'package:projectwithnode/views/screens/nav_screens/home_screen.dart';
import 'package:projectwithnode/views/screens/nav_screens/store_screen.dart';

class InnercategoryScreen extends StatefulWidget {
  final Category category;

  const InnercategoryScreen({super.key, required this.category});


  @override
  State<InnercategoryScreen> createState() => _InnercategoryScreenState();
}
class _InnercategoryScreenState extends State<InnercategoryScreen> {
  int _pageindex = 0;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      InnerCategoryContentWidget(category: widget.category),
      FavouriteScreen(),
      CategoryScreen(),
      StoreScreen(),
      CartScreen(),
      AccountScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageindex,
        onTap: (value) {
          setState(() {
            _pageindex = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Image.asset("assets/icons/home.png", width: 25), label: "Home"),
          BottomNavigationBarItem(icon: Image.asset("assets/icons/love.png", width: 25), label: "favourite"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "category"),
          BottomNavigationBarItem(icon: Image.asset("assets/icons/mart.png", width: 25), label: "Stores"),
          BottomNavigationBarItem(icon: Image.asset("assets/icons/cart.png", width: 25), label: "Cart"),
          BottomNavigationBarItem(icon: Image.asset("assets/icons/user.png", width: 25), label: "Account"),
        ],
      ),
      body: pages[_pageindex],
    );
  }
}
