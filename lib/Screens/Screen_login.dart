import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Controller/controller.dart';
import 'create_account.dart';
class LoginScreen extends StatelessWidget {
  UserController userController = Get.put(UserController());
  // bool isObscure = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


// FirebaseMessaging messaging = FirebaseMessaging.instance;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          autovalidateMode:AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Obx(
            () => SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          "Wellcome",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: Text("Sign in to continue!",
                            style: TextStyle(fontSize: 17, color: Colors.grey)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 20,right: 20),
                  child: TextFormField(
                    controller: userController.emailController.value,
                    decoration: InputDecoration(
                        hintText: "Email",
                        contentPadding: EdgeInsets.only(left: 10, bottom: 2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        )
                    ),
validator:
MultiValidator([
RequiredValidator(errorText: "Required Email"),
 EmailValidator(errorText: "Please Enter Valid Email"),
]),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 20,right: 20),
                  child: TextFormField(
                    controller: userController.passwordController.value,
                    decoration: InputDecoration(
                        hintText: "Password",
                        contentPadding: EdgeInsets.only(left: 10, bottom: 2),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        )
                    ),
                    validator:(val){
                      RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])');
                      if(val!.isEmpty){
                        return ("Required Password");
                      }
                      else if(val!.length<6){
                        return ("Password Must be more than 5 characters");
                      }
                      else if(!regex.hasMatch(val)){
                        return ("Password should contain upper,lower and digits");
                      }
                      return null;
                    }
                    // MultiValidator([
                    //   RequiredValidator(errorText: "Required Password"),
                    //  MinLengthValidator(6, errorText: "At Least 6 Character Required"),
                    // ]),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(300, 45) // put the width and height you want
                      ),
                  onPressed: () async {
                    formKey.currentState?.validate();
                    var respons = await userController.login();
                    if (respons == "Successful") {
                      Get.snackbar(
                        "Successful Login",
                        respons,
                        dismissDirection: DismissDirection.horizontal,
                      );
                    } else {
                      Get.snackbar("Alert", respons,
                          dismissDirection: DismissDirection.horizontal);
                    }
                  },
                  child: Text("Login"),
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: () {
                      Get.offAll(CreateAccount());
                      userController.passwordController.value.clear();
                      userController.emailController.value.clear();
                    },
                    child: Text("Create New Account"))
              ]),
            ),
          ),
        ),
      ),
    );
  }


  // Future<String>getDeviceToken()async{
  // String token =   await messaging.getToken.toString();
  // return token;
  // }

}
