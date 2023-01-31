import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/helpers/show_message_widget.dart';
import 'package:flutter/cupertino.dart';

class SignInProvider extends ChangeNotifier {
  // CONTROLLERS
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // VARIABLES
  bool isLoading = false;

  // To user sign up
  Future<dynamic> signIn() async {
    try {
      isLoading = true;
      notifyListeners();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showErrorMessage("USER TOPILMADI");
        isLoading = false;
        notifyListeners();
      } else if (e.code == 'wrong-password') {
        showErrorMessage("PASSWORD XATO");
        isLoading = false;
        notifyListeners();
        // toast
      } else {
        showErrorMessage("NOMA'LUM XATO");
        isLoading = false;
        notifyListeners();
      }
    }
  }
}
