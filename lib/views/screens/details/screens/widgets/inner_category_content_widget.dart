import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:projectwithnode/controllers/product_controller.dart';
import 'package:projectwithnode/controllers/subcategory_controller.dart';
import 'package:projectwithnode/models/category.dart';
import 'package:projectwithnode/models/subcategory.dart';
import 'package:projectwithnode/views/screens/details/screens/widgets/inner_banner_widget.dart';
import 'package:projectwithnode/views/screens/details/screens/widgets/inner_header_widget.dart';
import 'package:projectwithnode/views/screens/details/screens/widgets/subcategory_tile_widget.dart';
import 'package:projectwithnode/views/screens/nav_screens/widgets/reusable_text_widget.dart';
import 'package:projectwithnode/models/product.dart';
import 'package:projectwithnode/views/screens/nav_screens/widgets/product_item_widget.dart';

class InnerCategoryContentWidget extends StatefulWidget {
  final Category category;

  const InnerCategoryContentWidget({super.key, required this.category});


  @override
  State<InnerCategoryContentWidget> createState() => _InnerCategoryContentWidgetState();
}

class _InnerCategoryContentWidgetState extends State<InnerCategoryContentWidget> {
  late Future<List<SubCategory>> _subcategories;
  final SubcategoryController _subcategoryController=SubcategoryController();
  final ProductController _productController=ProductController();
  late Future<List<Product>> futureProducts;
  void initState(){
    _subcategories=_subcategoryController.getSubCategoriesByCategoryName(widget.category.name);
    futureProducts=_productController.loadProductsByCategory(widget.category.name);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(MediaQuery.of(context).size.height),
       child: InnerHeaderWidget()),
       body: SingleChildScrollView(
        child: Column(
          children: [
            InnerBannerWidget(image: widget.category.banner),
            Center(
              child: Text("Shop by Sub categories",
              style: GoogleFonts.quicksand(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              letterSpacing: 1.7)),
            ),
             FutureBuilder(future:_subcategories,
         builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child:  CircularProgressIndicator());
          }
          else if(snapshot.hasError){
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }
          else if(!snapshot.hasData || snapshot.data!.isEmpty){
            return Center(
              child: Text("No Banners"),
            );
          }
          else{
            final subcategories=snapshot.data;
            return  SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: List.generate((subcategories!.length/7).ceil(),(setIndex){
                  final start=setIndex*7;
                  final end=(setIndex+1)*7;
                  //create padding widget
                  return Padding(padding: EdgeInsets.all(8.0),
                  child:Row(
                    children: subcategories.sublist(start,end> subcategories.length ? subcategories.length : end)
                    .map((subcategory) => SubcategoryTileWidget(name: subcategory.subCategoryName, image: subcategory.image)).toList(),
                  ) ,
                  );
                }),
              ),
            );
          }
         }
        ),
        ReusableTextWidget(title: "Popular Products", subtitle:"view all"),
        FutureBuilder(future: futureProducts, 
    builder: (context,snapshot){
      if(snapshot.connectionState ==ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(),);
      }
      else if(snapshot.hasError){
        return Center(child: Text('Error : ${snapshot.error}'),);
      }
      else if(!snapshot.hasData || snapshot.data!.isEmpty){
        return Center(
          child: Text("No  Products under this category"),
        );
      }
      else{
        final products=snapshot.data;
        return SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products!.length,
            itemBuilder: (context,index){
              final product=products[index];
                return ProductItemWidget(product: product,);
            }),
        );
      }
    }),
          ],
        ),
        
        
       ),
    );
  }
}