import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectwithnode/controllers/order_controller.dart';
import 'package:projectwithnode/models/order.dart';
import 'package:projectwithnode/providers/order_provider.dart';
import 'package:projectwithnode/providers/user_provider.dart';
import 'package:projectwithnode/views/screens/details/screens/order_details_screen.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  @override
  void initState(){
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async{
    final user=ref.read(useprovider);
    if(user!=null){
      final  OrderController orderController=OrderController();
      try{
        final orders=orderController.loadOrders(buyerId: user.id);
        List<Order> order= await orders;
        ref.read(orderProvider.notifier).setOrders(order);
      }
      catch(e){
          print(e);
      }
    }
  }
  Future<void> _deleteOrder(String id) async{
    final OrderController orderController=OrderController();
    try{
      await  orderController.deleteOrder(id: id, context: context);
      // ref.read()
      _fetchOrders();
    } 
    catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    final orders=ref.watch(orderProvider);
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
              orders.length.toString(),
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
      body: orders.isEmpty ?  Center(
        child: Text("No orders yet"),
      ) :
      ListView.builder(
         itemCount:orders!.length,
        itemBuilder: (context,index){
        
        final order=orders[index];
       
        return InkWell(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context){
              return OrderDetailsScreen(order: order,);
            }));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 25),
            child: Container(
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
                                  onTap: (){
                                    _deleteOrder(order.id);
                                  },
                                  child: Image.asset('assets/icons/delete.png',
                                  width: 20,
                                  height: 20,
                                  ),
                                ),
          
                              )
                            ],
                          ),
                      ) 
            
                      ),
                  ],
            
                ),
            
              ),
            
            ),
          ),
        );
      })
      
    );
  }
}