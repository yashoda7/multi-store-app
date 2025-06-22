import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectwithnode/controllers/order_controller.dart';
import 'package:projectwithnode/providers/cart_provider.dart';
import 'package:projectwithnode/providers/user_provider.dart';
import 'package:projectwithnode/views/screens/details/screens/widgets/shipping_adress_screen.dart';

class Checkoutscreen extends ConsumerStatefulWidget {
  const Checkoutscreen({super.key});

  @override
  _CheckoutscreenState createState() => _CheckoutscreenState();
}

class _CheckoutscreenState extends ConsumerState<Checkoutscreen> {
  String selectedPaymentMethod = "stripe";
  final _orderController = OrderController();

  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(cartProvider);
    final _cartProvider = ref.watch(cartProvider.notifier);
    final user = ref.watch(useprovider);
    // final user=ref.watch(useprovider);

    final hasShippingAddress =
        user != null && user.state != null && user.state!.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ShippingAddressScreen()),
                  );
                },
                child: SizedBox(
  width: 355,
  height: 90, // Increased height to accommodate text
  child: Stack(
    clipBehavior: Clip.none,
    children: [
      Positioned(
        left: 0,
        top: 0,
        child: Container(
          width: 355,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFFEFF0F2),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      Positioned(
        left: 70,
        top: 17,
        child: SizedBox(
          width: 215,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Allows column to size itself
            children: [
              const Text(
                "Add Address",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "United States",
                style: GoogleFonts.lato(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                ),
              ),
              Text(
                "Enter city",
                style: GoogleFonts.lato(
                  color: const Color(0xFF7F808C),
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
      const Positioned(
        left: 16,
        top: 16,
        child: CircleAvatar(
          backgroundColor: Color(0xFFFBF7F5),
          radius: 21.5,
          backgroundImage: NetworkImage(
            'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F2ee3a5ce3b02828d0e2806584a6baa88.png',
          ),
        ),
      ),
    ],
  ),
),
              ),
              const SizedBox(height: 10),
              Text(
                "Your Item",
                style: GoogleFonts.quicksand(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: cartData.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final cartItem = cartData.values.toList()[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      height: 91,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFEFF0F2),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Row(
                          children: [
                            Container(
                              width: 78,
                              height: 78,
                              decoration: BoxDecoration(
                                color: const Color(0xFFBCC5FF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.network(
                                cartItem.image[0],
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 11),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartItem.productName,
                                    style: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.3,
                                    ),
                                  ),
                                  Text(
                                    cartItem.category,
                                    style: GoogleFonts.lato(
                                      color: Colors.blueGrey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "\$${cartItem.productPrice.toStringAsFixed(2)}",
                              style: GoogleFonts.robotoSerif(
                                fontSize: 14,
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Choose Payment Options",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RadioListTile<String>(
                title: Text(
                  "Stripe",
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: "stripe",
                groupValue: selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text(
                  "Cash On Delivery",
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: "cashOnDelivery",
                groupValue: selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: !hasShippingAddress
            ? TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ShippingAddressScreen()),
                  );
                },
                child: Text(
                  "Please enter shipping address",
                  style: GoogleFonts.montserrat(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : InkWell(
                onTap: () async {
                  if (selectedPaymentMethod == 'stripe') {
                    // Stripe payment flow should be handled here
                  } else {
                    await Future.forEach(
                        _cartProvider.getCartItems.entries, (entry) async {
                      var item = entry.value;
                      await _orderController.uploadOrders(
                        id: "",
                        fullName: ref.read(useprovider)!.fullName,
                        email: ref.read(useprovider)!.email,
                        state: ref.read(useprovider)!.state,
                        city: ref.read(useprovider)!.city,
                        locality: ref.read(useprovider)!.locality,
                        productName: item.productName,
                        productPrice: item.productPrice,
                        quantity: item.quantity,
                        category: item.category,
                        image: item.image[0],
                        buyerId: user.id,
                        vendorId: item.vendorId,
                        processing: true,
                        delivered: false,
                        context: context,
                      );
                    });
                  }
                },
                child: Container(
                  width: 338,
                  height: 58,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3854EE),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      selectedPaymentMethod == 'stripe'
                          ? "Pay Now"
                          : "Place Order",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
