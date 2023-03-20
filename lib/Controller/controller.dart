import 'package:chating_app/Screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:chating_app/Models/model_class.dart' as model;

class UserController extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final nameController = TextEditingController().obs;

  Future<String> signUp() async {
    String respons = "";
    String email = emailController.value.text.trim();
    String password = passwordController.value.text.trim();
    String name = nameController.value.text.trim();
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      Get.snackbar("Alert", "Please Fill All Fields",dismissDirection: DismissDirection.horizontal);
    }{
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      respons = "SUCCESSFULLY";
      var userId = value.user!.uid;

      var user = model.User(
          name: name,
          email: email,
          password: password,
          id: userId,
          notification_token: "",
          img_url: '',
          timestamp: DateTime.now().microsecondsSinceEpoch);
      await FirebaseFirestore.instance
          .collection("user")
          .doc(user.id)
          .set(user.toMap())
          .then((value) {
        respons = "DataSaved";
        // Get.to(HomeScreen());
      }).catchError((onError) {
        return respons = onError.toString();
      });
    });
    return respons;
  }}
  Future<String> login() async {
    String respons = "";
    String email = emailController.value.text.trim();
    String password = passwordController.value.text.trim();
    if(email.isEmpty||password.isEmpty){
      Get.snackbar("Alert", "Please Fill All Fields",dismissDirection: DismissDirection.horizontal);
    }
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      respons = "Successful";
      // Get.offAll(HomeScreen());
      emailController.value.clear();
      passwordController.value.clear();
    }).catchError((onError) {
      respons = onError.toString();
    });
    return respons;
  }

}
