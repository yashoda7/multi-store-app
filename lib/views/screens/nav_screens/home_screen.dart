import 'package:flutter/material.dart';
import 'package:projectwithnode/views/screens/nav_screens/widgets/banner_widget.dart';
import 'package:projectwithnode/views/screens/nav_screens/widgets/category_widget.dart';
import 'package:projectwithnode/views/screens/nav_screens/widgets/header_widgets.dart';
import 'package:projectwithnode/views/screens/nav_screens/widgets/popular_product.dart';
import 'package:projectwithnode/views/screens/nav_screens/widgets/reusable_text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidgets(),
            BannerWidget(),
            CategoryWidget(),
            ReusableTextWidget(title: "Popular", subtitle: "view all"),
            PopularProduct(),
          ],
        ),
      )
    );
  }
}