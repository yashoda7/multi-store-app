import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectwithnode/providers/user_provider.dart';
import 'package:projectwithnode/views/screens/authentication_screens/login_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projectwithnode/views/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async{
    await dotenv.load();
    //providing scope for managing state
  runApp(ProviderScope(child: const MyApp()));
}
//consumer widget -- to consume state chande

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  //method to check token  and set the user data is avaliable
  Future<void> _checkTokenAndSetUser(WidgetRef ref) async{
    //obtain the instance of sharedprefernce for local storage;
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    //we retriew authentication token and user data stred locally;
   String? token= sharedPreferences.getString('auth_token');
   String? userJson=sharedPreferences.getString('user');
   //if both are available we updates the user data
   if(token!=null && userJson!=null){
    ref.read(useprovider.notifier).setUser(userJson);
   }
   else{
    ref.read(useprovider.notifier).signout();
   }
  }
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  FutureBuilder(future: _checkTokenAndSetUser(ref), 
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final user=ref.watch(useprovider);
        // return user!=null ? MainScreen() : LoginScreen();
        return MainScreen();
      }),
    );
  }
}
