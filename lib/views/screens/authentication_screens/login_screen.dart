import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectwithnode/controllers/auth_controller.dart';
import 'package:projectwithnode/views/screens/authentication_screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // const LoginScreen({super.key});
  final GlobalKey <FormState> _formKey=GlobalKey<FormState>();

  late String email;

  late String password;

  bool isLoading=false;

  loginUser() async{
    setState(() {
      isLoading=true;
    });
    
    await  _authController.signInUser(context: context, email: email, password: password).whenComplete((){
      setState(() {
      isLoading=false;
    });
    });
    

  }

  final AuthController _authController=AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Text("Login with Account",style: 
                    GoogleFonts.getFont("Lato",color: Color(0xFF0d120E),
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.2,
                    )),
                  Text("To Explore The World Exclusive..",style:
                   GoogleFonts.getFont("Lato",color: Color(0xFF0d120E),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 0.2,)),
                  Image.asset("assets/images/Illustration.png",width: 200, height: 200,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Email',style: GoogleFonts.getFont('Nunito Sans',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2),),
                  ),
                  TextFormField(
                    onChanged: (value){
                      email=value;
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return "enter your email";
                      }
                      else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled:true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      labelText: 'Enter your email',
                      labelStyle: GoogleFonts.getFont('Nunito Sans',fontSize: 14,letterSpacing:0.1),
                      prefixIcon:Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset('assets/icons/email.png',height:20,width: 20,),
                      ) ,
                    ),
                  ),
                  SizedBox(height:20),
                   Align(
                    alignment: Alignment.topLeft,
                    child: Text('Email',style: GoogleFonts.getFont('Nunito Sans',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2),),
                  ),
                  TextFormField(
                    onChanged: (value){
                      password=value;
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return "enter your password";
                      }
                      else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled:true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      labelText: 'Enter your password',
                      labelStyle: GoogleFonts.getFont('Nunito Sans',fontSize: 14,letterSpacing:0.1),
                      prefixIcon:Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset('assets/icons/password.png',height:20,width: 20,),
                      ) ,
                      suffixIcon: Icon(Icons.visibility),
                    ),
                  ), 
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: () async{
                      if(_formKey.currentState!.validate()){
                      //  await  _authController.signInUser(context: context, email: email, password: password);
                      loginUser();
                        // print("correct");
                      }
                      else{
                        print("error");
                      }
                    },
                    child: Container(
                      width: 319,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: LinearGradient(
                          colors:[Color(0xFF102DE1),Color(0xCC0D6EFF)] 
                        )
                      ),
                      child: GestureDetector(
                        child: Center(
                          child:  isLoading ?CircularProgressIndicator(color: Colors.white,) :Text("Sign in",
                        style: GoogleFonts.getFont("Lato",color: Colors.white,
                      // fontWeight: FontWeight.bold,
                      fontSize: 17,
                      letterSpacing: 0.2,),
                        ),
                     ),
                     onTap: (){
                                  
                     },
                    ),
                                    ),
                  ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("Need an Account?",style: GoogleFonts.roboto(fontWeight: FontWeight.w500,letterSpacing: 1, ),),
                   InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (_) => RegisterScreen()));
                    },
                    child: Text("SignUp",style: GoogleFonts.roboto(fontWeight: FontWeight.bold,letterSpacing: 1,color: Color(0xFF102DE1)),)),
                ],),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}