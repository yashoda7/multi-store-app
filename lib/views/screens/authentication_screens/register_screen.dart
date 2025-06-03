import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectwithnode/controllers/auth_controller.dart';
import 'package:projectwithnode/views/screens/authentication_screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // const RegisterScreen({super.key});
  final GlobalKey <FormState> _formKey=GlobalKey<FormState>();

  final AuthController _authController=AuthController();

  late String email;

  late String fullName;

  late String password;
  
  bool isLoading=false;

  registerUser() async{
    setState(() {
      isLoading=true;
    });
    
    await  _authController.SignUpUsers(context: context, email: email,fullName: fullName, password: password).whenComplete((){
      setState(() {
      isLoading=false;
    });
    });
    

  }

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
                    Text("Create Account",style: 
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
                  // Align(
                  //   alignment: Alignment.topLeft,
                  //   child: Text('Email',style: GoogleFonts.getFont('Nunito Sans',
                  //   fontWeight: FontWeight.w600,
                  //   letterSpacing: 0.2),),
                  // ),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     fillColor: Colors.white,
                  //     filled:true,
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(9),
                  //     ),
                  //     focusedBorder: InputBorder.none,
                  //     enabledBorder: InputBorder.none,
                  //     labelText: 'Enter your email',
                  //     labelStyle: GoogleFonts.getFont('Nunito Sans',fontSize: 14,letterSpacing:0.1),
                  //     prefixIcon:Padding(
                  //       padding: const EdgeInsets.all(10.0),
                  //       child: Image.asset('assets/icons/email.png',height:20,width: 20,),
                  //     ) ,
                  //   ),
                  // ),
                  SizedBox(height:20),
                   Align(
                    alignment: Alignment.topLeft,
                    child: Text('User',style: GoogleFonts.getFont('Nunito Sans',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2),),
                  ),
                  TextFormField(
                    onChanged: (value){
                      fullName=value;
                    },
                     validator:(value){
                      if(value!.isEmpty){
                        return 'enter your full name';
                      }
                      else{
                        return null;
                      }
                    } ,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled:true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      labelText: 'Enter Your Name',
                      labelStyle: GoogleFonts.getFont('Nunito Sans',fontSize: 14,letterSpacing:0.1),
                      prefixIcon:Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset('assets/icons/user.jpeg',height:20,width: 20,),
                      ) ,
                    ),
                  ), 
                  SizedBox(height: 20,),
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
                    validator:(value){
                      if(value!.isEmpty){
                        return 'enter your email';
                      }
                      else{
                        return null;
                      }
                    } ,
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
                     validator:(value){
                      if(value!.isEmpty){
                        return 'enter your password';
                      }
                      else{
                        return null;
                      }
                    } ,
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
                  InkWell (
                    onTap: () async{
                      if(_formKey.currentState!.validate()){
                        // print("connected");
                        // await  _authController.SignUpUsers(context: context, email: email, fullName: fullName, password: password);
                        registerUser();
                      }
                      else{
                        print("wrong");
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
                        child: Center(child: isLoading ? CircularProgressIndicator(color: Colors.white,):
                        Text("Sign up",
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
                  Text("Already have an Account?",style: GoogleFonts.roboto(fontWeight: FontWeight.w500,letterSpacing: 1, ),),
                   InkWell(
                    onTap: (){
                      //  Navigator.pop(context);
                      Navigator.push(context,MaterialPageRoute(builder: (_) => LoginScreen()));
                    },
                    child: Text("Sign In",style: GoogleFonts.roboto(fontWeight: FontWeight.bold,letterSpacing: 1,color: Color(0xFF102DE1)),)),
                ],)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}