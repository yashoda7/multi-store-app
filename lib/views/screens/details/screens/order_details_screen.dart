import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectwithnode/models/order.dart';

class OrderDetailsScreen extends StatelessWidget {
  // const OrderDetailsScreen({super.key});
  final Order order;
  const OrderDetailsScreen({super.key,required this.order});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text(
          order.productName,
          style: GoogleFonts.montserrat(
            // fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ) ,
      body:  Column(
        children: [
          Container(
                  width: 335,
                  height: 153,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child:Container(
                             width: 335,
                             height: 153,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(0xFFEFF0F2),
                                  
                                ),
                                borderRadius: BorderRadius.circular(9),
              
                              ),
                              child:  Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    left: 13,
                                    top:9,
                                    child:Container(
                                      width: 78,
                                      height: 78,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: Color(
                                          0xFFBCC5FF
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                            left: 10,
                                            top: 5,
                                            child: Image.network(order.image,
                                            width: 58,
                                            height: 67,
                                            fit: BoxFit.cover,
                                            
                                            )
                                            ),
                                          Positioned(
                                            left: 101,
                                            top: 14,
                                            child: SizedBox(
                                              width: 216,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: Column(
                                                        mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          SizedBox(
                                                            width: double.infinity,
                                                            child: Text(
                                                              order.productName,
                                                              style: GoogleFonts.montserrat(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w700,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Align(
                                                            alignment: Alignment.center,
                                                            child: Text(order.category,
                                                            style: GoogleFonts.montserrat(
                                                              color: Color(0xFF7F808C),
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 12,
                                                            ),
                                                            ),
                                                          ),
                                                           SizedBox(
                                                            height: 4,
                                                          ),
                                                          Text(
                                                            "\$ ${order.productPrice.toStringAsFixed(2)}",
                                                             style: GoogleFonts.montserrat(
                                                              fontWeight: FontWeight.bold,
                                                              color: Color(0xFF0B0C1E),
                                                             
                                                              fontSize: 14,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 13,
                                            top:113,
                                            child: Container(
                                              width: 100,
                                              height: 25,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                color: order.delivered == true ?
                                                Color( 0xFF3C55EF) :
                                                order.processing ==true ? Colors.purple : Colors.red,
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Positioned(
                                                    left: 9,
                                                    top: 2,
                                                    child: Text(
                                                      order.delivered == true ? "Delivered" :
                                                      order.processing ==true ? "Processing" :
                                                      "Cancelled",
                                                      style: GoogleFonts.montserrat(
                                                        fontSize:  12,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white,
                                                        letterSpacing: 1.3
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          )
                                        ],
                                      ),
              
              
                                    ) ,
                                  ),
                                  Positioned(
                                    top: 115,
                                    left: 298,
                                    child: InkWell(
                                      onTap: (){},
                                      child: Image.asset('assets/icons/delete.png',
                                      width: 20,
                                      height: 20,
                                      ),
                                    ),
              
                                  )
                                ],
                              ),
                          ) ,
                
                          ),
                      ],
                
                    ),
                
                  ),
                
                ),
        ],
      ),
      );
  }
}