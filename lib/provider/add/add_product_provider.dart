import 'package:firebaseapp/data/remote/firestore_service.dart';
import 'package:firebaseapp/helpers/show_message_widget.dart';
import 'package:flutter/cupertino.dart';

class AddProductProvider extends ChangeNotifier {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productDescController = TextEditingController();
  bool isLoading = false;

  void writeData() async {
    isLoading = true;
    notifyListeners();
    await ChatagramFirestoreService.writeData(
            title: productNameController.text,
            desc: productDescController.text,
            img:
                "https://openshop.uz/public/storage/uploads/products/photos/202210/3YxYHWuweWZ4zD0iLuik4f8JHp8eXS7Ka2NpBlql.jpg")
        .then((value) {
      if (value == true) {
        isLoading = false;
        notifyListeners();
        showErrorMessage("Mahsulot muvoffaqiyatli qo'shildi");
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }
}
