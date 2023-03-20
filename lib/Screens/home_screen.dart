import 'dart:io';

import 'package:chating_app/Controller/controller.dart';
import 'package:chating_app/Screens/Screen_login.dart';
import 'package:chating_app/Screens/itemchat.dart';
import 'package:chating_app/helper/database_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_utils/custom_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../helper/message.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chating_app/Models/model_class.dart' as model;

class HomeScreen extends StatelessWidget {
  UserController userController = Get.put(UserController());

  model.User? user;
  var uid = FirebaseAuth.instance.currentUser!.uid;
  String selectedImagePath = '';
  var messagesController = TextEditingController();
  String messageType="text";
  @override
  Widget build(BuildContext context) {
    print(uid);
    print(user!.id);
    return Scaffold(
        appBar: AppBar(
          title: Text(user!.name),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  Get.defaultDialog(
                    title: "Chose Any Option",
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        TextButton(
                            onPressed: () {
                              Get.back();
                              userController.emailController.value.clear();
                              userController.passwordController.value.clear();
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )),
                        Spacer(
                          flex: 1,
                        ),
                        TextButton(
                            onPressed: () {
                              Get.offAll(LoginScreen());
                            },
                            child: Text(
                              "Done",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )),
                        Spacer(),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.logout))
          ],
        ),
        ///chat

        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<DatabaseEvent>(
                  stream: chatRef.child("${uid}/inbox/${user!.id}").onValue,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator.adaptive());
                    }
                    var messages = snapshot.data!.snapshot.children
                        .map((e) => Message.fromMap(
                            Map<String, dynamic>.from(e.value as dynamic)))
                        .toList();

                    return messages.isNotEmpty
                        ? Column(
                            children: [
                              Expanded(
                                child: Column(
                                  children: messages.map((e) => ItemChat(message: e)).toList()
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Spacer(),
                            ],
                          )
                        : NotFound(message: "No Messages");
                  }),
            ),
            Container(
              height: 11.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    blurRadius: 1,
                    spreadRadius: 2,
                  )
                ],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextField(
                          controller: messagesController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Write your message here....",
                              contentPadding: EdgeInsets.only(bottom: 7)),
                        ),
                      ),
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(.4),
                              blurRadius: .5,
                            )
                          ]),
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     Get.defaultDialog(
                  //       title: "Select Path",
                  //       content: Column(
                  //         children: [
                  //           Row(
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               IconButton(
                  //                   onPressed: () async {
                  //                     selectedImagePath =
                  //                         await selectImageFromGallery();
                  //                     if (selectedImagePath != '') {
                  //                       Get.back();
                  //                     } else {
                  //                       ScaffoldMessenger.of(context)
                  //                           .showSnackBar(SnackBar(
                  //                         content: Text("No Image Selected !"),
                  //                       ));
                  //                     }
                  //                   },
                  //                   icon: Icon(
                  //                     Icons.camera,
                  //                   )),
                  //               SizedBox(
                  //                 width: 80,
                  //               ),
                  //               IconButton(
                  //                   onPressed: () async {
                  //                     selectedImagePath =
                  //                         await selectImageFromCamera();
                  //                     if (selectedImagePath != '') {
                  //                       Get.back();
                  //                     } else {
                  //                       ScaffoldMessenger.of(context)
                  //                           .showSnackBar(SnackBar(
                  //                         content: Text("No Image Captured !"),
                  //                       ));
                  //                     }
                  //                   },
                  //                   icon: Icon(
                  //                     Icons.camera_alt_outlined,
                  //                   )),
                  //             ],
                  //           ),
                  //           Row(
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Text("Gallery"),
                  //               SizedBox(
                  //                 width: 75,
                  //               ),
                  //               Text("Camera"),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  //   icon: Icon(Icons.attachment_rounded),
                  // ),
                  TextButton(
                      onPressed: () {
                        String text = messagesController.text;
                        if (text.isNotEmpty) {
                          var timestamp = DateTime.now().millisecondsSinceEpoch;
                          var message = Message(
                              id: timestamp.toString(),
                              timestamp: timestamp,
                              text: text,
                              sender_id: uid,
                              message_type: messageType,
                              receiver_id: user!.id
                          );
                          messagesController.clear();
                          sendMessage(message).catchError((error) {
                            Get.snackbar("error", error.toString());
                          });
                        }
                      },
                      child: Container(
                          height: 3.6.h,
                          width: 15.w,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(Radius.circular(7))),
                          child: Center(
                              child: Text(
                                "Send",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ))))
                ],
              ),
            ),
          ],
        ),

        );
  }

  HomeScreen({
     this.user,
  });
// selectImageFromGallery() async {
//   XFile? file = await ImagePicker()
//       .pickImage(source: ImageSource.gallery, imageQuality: 10);
//   if (file != null) {
//     return file.path;
//   } else {
//     return '';
//   }
// }

// selectImageFromCamera() async {
//   XFile? file = await ImagePicker()
//       .pickImage(source: ImageSource.camera, imageQuality: 10);
//   if (file != null) {
//     return file.path;
//   } else {
//     return '';
//   }
// }

// HomeScreen({
//   required this.user,
// });
}
