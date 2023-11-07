
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthController {


  LoginUser(String email,String password)async{
    String res = 'Some error accured';
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final _uid = user!.uid;
    try{
      if(email.isNotEmpty &&  password.isNotEmpty ){
        UserCredential _cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'success';
      }else{
      res = "Please Fields must not be empty";
      }
    }catch(e){
      res = e.toString();
    }
    return res;
  }

  }

