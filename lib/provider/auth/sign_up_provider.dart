import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/helpers/show_message_widget.dart';
import 'package:flutter/cupertino.dart';

class SignUpProvider extends ChangeNotifier {
  // CONTROLLERS
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // VARIABLES
  bool isLoading = false;

  // To user sign up
  Future<dynamic> signUp() async {
    try {
      isLoading = true;
      notifyListeners();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showErrorMessage("PAROL KUCHSIZ ");
        isLoading = false;
        notifyListeners();
      } else if (e.code == 'email-already-in-use') {
        showErrorMessage("EMAIL ALLAQACHON OLIB BO'LINGAN");
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
