import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectwithnode/providers/cart_provider.dart';
import 'package:projectwithnode/views/screens/details/screens/widgets/checkoutscreen.dart';
import 'package:projectwithnode/views/screens/main_screen.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {

  @override

  Widget build(BuildContext context) {
     final cartData=ref.watch(cartProvider);
    final cartCount = ref.watch(cartProvider.notifier).totalCartItemsCount();
    final _cartproovider=ref.read(cartProvider.notifier);
    final totalAmount=ref.watch(cartProvider.notifier).calculateTotalAmount();
    // final cartCount =0;

   return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height),
         child: Container(
          width: MediaQuery.of(context).size.width,
          height: 118,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            image: DecorationImage(
              image:AssetImage("assets/icons/cartb.png"),
            fit: BoxFit.cover,

            ),
          ),
          child: Stack(
            children: [
                Positioned(
  left: 322,
  top: 52,
  child: Stack(
    clipBehavior: Clip.none,
    children: [
      Image.asset("assets/icons/not.png", width: 25, height: 25),
      Positioned(
        right: -4,
        top: -4,
        child: Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: Colors.yellow.shade800,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              // cartData.length.toString(),
              cartCount.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                  Positioned(
                    top:51,
                    left: 61,
                    child: Text(
                      "My Cart",
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  )
            ],
          ),
         )
         ),
         body:cartData.isEmpty ?Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                "your shopping cart is empty\n you can add product to your cart from the button below",
              style: GoogleFonts.roboto(
                fontSize: 15,
                letterSpacing: 1.7
              ),),
              TextButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return MainScreen();
                }));
              },
               child: Text("Shop Now")),
            ],
          ),
         ) :SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 49,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 49,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Color(0xFFD7DDFF),
                          ),

                        ),
                        ),
                        Positioned(
                          left: 44,
                          top: 19,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)
                            ),
                          ),
                          ),
                        Positioned(
                          left: 69,
                          top: 14,
                          child: Text("you have ${cartCount} items",
                          style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.7,
                          ),
                          ),
                        ),
                    ],
                  ),
                ),
               ListView.builder(
              shrinkWrap: true,
              itemCount: cartData.length, // not cartCount
              itemBuilder: (context, index) {
                final cartItem = cartData.values.toList()[index];
                      return Card(
                        child: SizedBox(
                          height: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                  cartItem.image[0],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 10,),
                             Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(cartItem.productName,
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,

                                ),
                                ),
                                Text(
                                  cartItem.category,
                                  style: GoogleFonts.roboto(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                 "\$${ cartItem.productPrice.toStringAsFixed(2)}",
                                  style: GoogleFonts.lato(
                                    color: Colors.pink,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,

                                  ),
                                 
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: Color(
                                          0xFF102DE1,
                                        ),

                                      ),
                                      child:Row(
                                        children: [
                                          IconButton(onPressed: (){
                                            _cartproovider.decrementCartItem(cartItem.productId);
                                          },
                                          color: Colors.white,
                                           icon: Icon(CupertinoIcons.minus)), 
                                           Text(
                                            cartItem.quantity.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                           ),
                                            IconButton(onPressed: (){
                                              _cartproovider.incrementCartItem(cartItem.productId);
                                            },
                                          color: Colors.white,
                                           icon: Icon(CupertinoIcons.plus)), 
                                        ],
                                      ) ,
                                    
                                    ),
                                    
                                  ],
                                ),
                              IconButton(onPressed: (){
                                _cartproovider.removeCartItem(cartItem.productId);
                              },
                                // color: Colors.white,
                                  icon: Icon(CupertinoIcons.delete)), 
                              ],
                             )
                            ],
                          ),
                        ),
                      );
                  } )
              ],
            ),
         ),
        bottomNavigationBar: SafeArea(
  child: Container(
    height: 80,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        top: BorderSide(color: Color(0xFFC4C4C4)),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Subtotal Section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Subtotal',
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: Color(0xFFA1A1A1),
              ),
            ),
            SizedBox(height: 4),
            Text(
              "\$${totalAmount.toString()}",
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF6464),
              ),
            ),
          ],
        ),

        // Checkout Button
        InkWell(
          onTap:  totalAmount==0.0 ? null :() {
            // TODO: Handle checkout
            Navigator.push(context,MaterialPageRoute(builder: (context){
              return Checkoutscreen();
            }),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: totalAmount==0 ? Colors.grey :
              Color(0xFF1532E7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Text(
                  'Checkout',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ],
    ),
  ),
),

    );
  }     
}