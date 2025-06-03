import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectwithnode/models/product.dart';
import 'package:projectwithnode/providers/cart_provider.dart';
import 'package:projectwithnode/services/manage_http_response.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key,required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final _cartproovider=ref.read(cartProvider.notifier);
    final cartData=ref.watch(cartProvider);
    final isInCart=cartData.containsKey(widget.product.id);
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details",style: GoogleFonts.quicksand(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){},
             icon: Icon(Icons.favorite),),

        ],

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 260,
              height: 275,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left:0,
                    top: 50,
                    child: Container(
                      width: 260,
                      height: 260,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(130),
                        color: Color(0XFFD8DDFF),
                      ),
                      
                    )
                  ),
                  Positioned(
                    left: 22,
                    top: 0,
                    child: Container(
                      width: 216,
                      height: 274,
                      decoration: BoxDecoration(
                        color: Color(0xFF9CA8FF),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: SizedBox(

                        height: 300,
                        child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.product.images.length,
                          itemBuilder: (context,index){
                            return Image.network(widget.product.images[index],
                            width: 198,
                            height: 225,
                            fit:BoxFit.cover,
                            );

                          }),
                      ),
                    ),

                    )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.product.productName,style: GoogleFonts.roboto(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Color(0xFF3C55EF)
                ),),
                Text("\$ ${widget.product.productPrice.toString()}",
                style: GoogleFonts.roboto(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Color(0xFF3C55EF),
                ),
                ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.product.category,
            style:GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Colors.grey
                ),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("About",
                style: GoogleFonts.lato(
                  fontSize: 17,
                  letterSpacing: 1.7,
                  color: Color(0xFF363330),
                ),
                ),
                Text(widget.product.description,
                style: GoogleFonts.mochiyPopOne(
                  letterSpacing: 2,
                  fontSize: 15
                ),),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(8),
        child: InkWell(
          onTap: isInCart? null : (){
            _cartproovider.addProductToCart(
              productName: widget.product.productName, 
              productPrice: widget.product.productPrice, 
              category: widget.product.category, 
              image: widget.product.images, 
              vendorId: widget.product.vendorId, 
              productQuantity: widget.product.quantity,
               quantity: 1,
                productId: widget.product.id,
                 description: widget.product.description,
                  fullName: widget.product.fullName);
                  showSnackBar(context,widget.product.productName);
          },
          child: Container(
            height: 46,
            width: 386,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Color(0xFF3B54EE),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text("Add to cart",
              style: GoogleFonts.mochiyPopOne(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),),
            ),
          ),
        )
      ),
    );
  }
}