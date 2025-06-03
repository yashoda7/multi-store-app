import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import 'package:projectwithnode/models/user.dart';

class UserProvider extends StateNotifier<User?>{
  UserProvider():
  super(
    User(
      id: "",
     fullName: "", 
     email: "", 
     state: "", 
     city: "", 
     locality: "",
      password: "",
       token: ""));
       User? get user => state;
      //set method
      void setUser(String userJson){
        state=User.fromJson(userJson);
      } 
      // final useprovider =StateNotifierProvider<UserProvider,User?>((ref) => UserProvider());
      //method to clear data
      void signout(){
        state=null;
      }
      // method to recrete the state
       // Inside UserProvider
void recreateUserState({
  required String state,
  required String city,
  required String locality,
}) {
  if (this.state != null) {
    this.state = User(
      id: this.state!.id,
      fullName: this.state!.fullName,
      email: this.state!.email,
      state: state,
      city: city,
      locality: locality,
      password: this.state!.password,
      token: this.state!.token,
    );
  }
}

}
    final useprovider =StateNotifierProvider<UserProvider,User?>((ref) => UserProvider());

