import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectwithnode/controllers/auth_controller.dart';
import 'package:projectwithnode/providers/user_provider.dart';

class ShippingAddressScreen extends ConsumerStatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  ConsumerState<ShippingAddressScreen> createState() =>
      _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends ConsumerState<ShippingAddressScreen> {
  final AuthController _authController = AuthController();
  late TextEditingController stateController;
  late TextEditingController cityController;
  late TextEditingController localityController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    final user = ref.read(useprovider);

    stateController = TextEditingController(
      text: user?.state.isNotEmpty == true ? user!.state : "",
    );
    cityController = TextEditingController(
      text: user?.city.isNotEmpty == true ? user!.city : "",
    );
    localityController = TextEditingController(
      text: user?.locality.isNotEmpty == true ? user!.locality : "",
    );
  }

  // Show loading dialog
  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 20),
                Text(
                  "Updating...",
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final updateUser = ref.read(useprovider.notifier);

    return Scaffold(
      backgroundColor: Colors.white.withAlpha(233),
      appBar: AppBar(
        backgroundColor: Colors.white.withAlpha(233),
        title: Text(
          "Delivery",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Where will your order \n be shipped',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextFormField(
                  controller: stateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter State";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: "State"),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: cityController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter City";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: "City"),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: localityController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Locality";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: "Locality"),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(9.0),
        child: InkWell(
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              _showLoadingDialog();

              final user = ref.read(useprovider);
              if (user == null) {
                Navigator.pop(context); // Close loading dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("User not found")),
                );
                return;
              }

              try {
                await _authController.updateUserLocation(
                  context: context,
                  id: user.id,
                  state: stateController.text,
                  city: cityController.text,
                  locality: localityController.text,
                );

                updateUser.recreateUserState(
                  state: stateController.text,
                  city: cityController.text,
                  locality: localityController.text,
                );

                if (!context.mounted) return;

                Navigator.pop(context); // Close loading dialog
                Navigator.pop(context); // Go back to previous screen
              } catch (e) {
                if (!context.mounted) return;

                Navigator.pop(context); // Close loading dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Failed to update address: $e")),
                );
              }
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF3854EE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "Save",
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
