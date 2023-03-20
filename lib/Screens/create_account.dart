import 'package:chating_app/Models/model_class.dart';
import 'package:chating_app/Screens/home_screen.dart';
import 'package:chating_app/Screens/user_list.dart';
import 'package:custom_utils/custom_utils.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import '../Controller/controller.dart';

class CreateAccount extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Obx(() => SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back_ios)),
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          "Wellcome",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: Text("Create Account to continue!",
                            style: TextStyle(fontSize: 17, color: Colors.grey)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                      controller: userController.nameController.value,
                      decoration: InputDecoration(
                        hintText: "Username",
                        contentPadding: EdgeInsets.only(left: 10, bottom: 2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      // validator: RequiredValidator(errorText: 'Required Name'),
                      validator: (val) {
                        RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])');
                        if (val!.isEmpty) {
                          return ("Required Name");
                        } else if (!regex.hasMatch(val)) {
                          return ("Name should contain upper and lower character");
                        }
                        return null;
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    controller: userController.emailController.value,
                    decoration: InputDecoration(
                        hintText: "Email",
                        contentPadding: EdgeInsets.only(left: 10, bottom: 2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        )),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required Email"),
                      EmailValidator(errorText: 'Please Enter Valid Email'),
                    ]),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                      controller: userController.passwordController.value,
                      decoration: InputDecoration(
                          hintText: "Password",
                          contentPadding: EdgeInsets.only(left: 10, bottom: 2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          )),
                      validator: (val) {
                        RegExp regex =
                            RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])');
                        if (val!.isEmpty) {
                          return ("Required Password");
                        } else if (val!.length < 6) {
                          return ("Password Must be more than 6 characters");
                        } else if (!regex.hasMatch(val)) {
                          return ("Password should contain upper,lower and digits");
                        }
                        return null;
                      }
                      // validator: RequiredValidator(errorText: 'Required Password'),
                      ),
                ),
                SizedBox(
                  height: 80,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: Size(300, 45)),
                  onPressed: () async {
                    formKey.currentState?.validate();
                    var respons = await userController.signUp();
                    if (respons == "DataSaved") {
                      Get.snackbar(
                        "Congratulation",
                        respons,
                        dismissDirection: DismissDirection.horizontal,
                      );
                      // Get.offAll(HomeScreen());
                      userController.nameController.value.clear();
                      userController.passwordController.value.clear();
                      userController.emailController.value.clear();
                    } else {
                      Get.snackbar("title", respons,
                          dismissDirection: DismissDirection.horizontal);
                    }
                  },
                  child: Text("SignUp"),
                ),
              ]),
            )),
      )),
    );
  }
}
