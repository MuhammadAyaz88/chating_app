import 'package:chating_app/Models/model_class.dart';
import 'package:chating_app/Screens/home_screen.dart';
import 'package:chating_app/helper/fcm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chating_app/Models/model_class.dart' as model;
import 'package:get/get.dart';

class Test extends StatefulWidget {
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  var uid = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  void initState(){
    Updatenotification();
    super.initState();
  }
  // var uid = FirebaseAuth.instance.currentUser!.uid;
  // TextEditingController nameController = TextEditingController();
  // TextEditingController emaiController = TextEditingController();
  //
  // void initState(){
  //   Updatenotification();
  //   super.initState();
  // }

//   var uid = FirebaseAuth.instance.currentUser!.uid;
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
// void initState(){
//   updateNotification();
//   super.initState();
// }

// TextEditingController nameController = TextEditingController();
// TextEditingController emailController = TextEditingController();

//   void initState (){
//   updateNotification();
//   super.initState();
//   }

  // void initState() {
  //   updateNotification();
  //   super.initState();
  // }

  // void initState() {
  //   updateNotification();
  //   super.initState();
  // }

  // TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Test Screen"),
          centerTitle: true,
        ),
        body:
//         FutureBuilder<DocumentSnapshot>(
//           future: FirebaseFirestore.instance.collection("user").doc(uid).get(),
//           builder: (context,snapshot) {
//           if (snapshot.connectionState==ConnectionState.waiting){
//            return Center(child: CircularProgressIndicator.adaptive());
//           }
//           var user = model.User.fromMap(snapshot.data!.data() as Map<String, dynamic>);
//           return ListTile(
//             title: Text(user.name),
//             subtitle: Text(user.email),
//             onTap: (){
//               Get.defaultDialog(
//                 title: "Update data",
//                 content: Column(
//                   children: [
//                     TextFormField(
//                     controller: nameController..text = user.name,
//                     ), TextFormField(
//                     controller: emailController..text = user.email,
//                     ),
//                   ],
//                 ),
//                 actions: [
//                   OutlinedButton(onPressed: () async {
// String name = nameController.text.trim();
// String email = emailController.text.trim();
// await FirebaseFirestore.instance.collection("user").doc(uid).update({"name":name, "email":email}).then((value) {
// Get.back();
// });
//                   }, child: Text("Update")),
//                   OutlinedButton(onPressed: (){
//                     Get.back();
//                   }, child: Text("No")),
//                 ]
//               );
//             },
//           );
//         },),
        
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("user").where("id",isNotEqualTo: uid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            var users = snapshot.data!.docs.map((e) =>
                model.User.fromMap(e.data() as Map<String, dynamic>)).toList();
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                var user = users[index];
                return ListTile(
                  onTap: (){
                    Get.to(HomeScreen(user:user));
                  },
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  // onTap: () {
                  //   Get.defaultDialog(
                  //     title: "Update data",
                  //     content: Column(
                  //       children: [
                  //         TextFormField(
                  //           controller: nameController..text = user.name,
                  //         ), TextFormField(
                  //           controller: emaiController..text = user.email,
                  //         ),
                  //       ],
                  //     ),
                  //     actions: [OutlinedButton(onPressed: () async {
                  //     String name = nameController.text.trim();
                  //     String email = emaiController.text.trim();
                  //     await FirebaseFirestore.instance.collection("user").doc(
                  //         uid).update({"name": name, "email": email}).then((value) {
                  //       Get.back();
                  //     });
                  //   }, child: Text("Update"),),
                  //   OutlinedButton(onPressed: () {
                  //   Get.back();
                  //   }, child: Text("No"),),]
                  //   );
                  // },
                );
              },);
          },
        )

      // StreamBuilder<QuerySnapshot>(
      //   stream: FirebaseFirestore.instance.collection("user").snapshots(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return CircularProgressIndicator.adaptive();
      //     }
      //     var users = snapshot.data!.docs
      //         .map(
      //             (e) => model.User.fromMap(e.data() as Map<String, dynamic>))
      //         .toList();
      //
      //     return ListView.builder(
      //       itemCount: users.length,
      //       itemBuilder: (BuildContext context, int index) {
      //         var user = users[index];
      //         return ListTile(
      //           onTap: () {
      //             Get.defaultDialog(
      //               title: "Update data",
      //               content: Column(
      //                 children: [
      //                   TextFormField(
      //                     controller: nameController..text = user.name,
      //                   ),
      //                   TextFormField(
      //                     controller: emailController..text = user.email,
      //                   ),
      //                 ],
      //               ),
      //               actions: [
      //                 OutlinedButton(
      //                     onPressed: () async {
      //                       String name = nameController.text.trim();
      //                       String email = nameController.text.trim();
      //                       await FirebaseFirestore.instance
      //                           .collection("user")
      //                           .doc(uid)
      //                           .update({"name": name, "email": email}).then((value) {
      //                         Get.back();
      //                       });
      //
      //                     },
      //                     child: Text("Update")),
      //                 OutlinedButton(
      //                     onPressed: () {
      //                       Get.back();
      //                     },
      //                     child: Text("No"))
      //               ],
      //             );
      //           },
      //           title: Text(user.name),
      //           subtitle: Text(user.email),
      //         );
      //       },
      //     );
      //   },
      // )

//       FutureBuilder<DocumentSnapshot>(
//         future: FirebaseFirestore.instance.collection("user").doc(uid).get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator.adaptive());
//           }
//           var user =
//               model.User.fromMap(snapshot.data!.data() as Map<String, dynamic>);
//           return ListTile(
//             title: Text(user.name),
//             subtitle: Text(user.email),
//             trailing:IconButton(onPressed: () {
//             Get.defaultDialog(
//               title: "Please update your data",
//             content: Column(
//               children: [
//                 TextFormField(
// controller: nameController..text = user.name,
//                 ), TextFormField(
// controller: emailController..text = user.email,
//                 ),
//
//               ],
//             ),
//               actions: [
//                 OutlinedButton(onPressed: () async {
//                   String name = nameController.text.trim();
//                   await FirebaseFirestore.instance.collection("user").doc(uid).update(
//                       {"name": name}).then((value) {
//                         Get.back();
//                   });String email = emailController.text.trim();
//                   await FirebaseFirestore.instance.collection("user").doc(uid).update(
//                       {"email": email}).then((value) {
//                         Get.back();
//                   });
//                 }, child: Text("Update")),
//                 OutlinedButton(onPressed: () async {
//                Get.back();
//                 }, child: Text("No")),
//               ],
//             );
//             }, icon: Icon(Icons.edit),),
//
//
//
//             // Delete Method
//
//             // onTap: () {
//             //   Get.defaultDialog(
//             //       content: TextFormField(
//             //         controller: nameController..text = user.name,
//             //       ),
//             //       actions: [
//             //         OutlinedButton(
//             //             onPressed: () async {
//             //               String name = nameController.text.trim();
//             //               await FirebaseFirestore.instance
//             //                   .collection("user")
//             //                   .doc(uid)
//             //                   .update({"name": name}).then((value) {
//             //                 Get.back();
//             //               });
//             //             },
//             //             child: Text("Save")),
//             //         OutlinedButton(
//             //             onPressed: () async {
//             //               Get.back();
//             //             },
//             //             child: Text("No"))
//             //       ]);
//             // },
// // leading:IconButton(
// //     onPressed: (){
// // Get.defaultDialog(
// //   actions: [
// //     OutlinedButton(onPressed: () async {
// //       String name = nameController.text.trim();
// //       await FirebaseFirestore.instance.collection("user").doc(uid).delete().then((value) {
// //         Get.back();
// //       });
// //     }, child: Text("Delete")),
// //     OutlinedButton(onPressed: (){
// //       Get.back();
// //     }, child: Text("No")),
// //   ],
// //   title: "Delete your data",
// //   content: Column(
// //     children: [
// //       TextFormField(
// //         controller: nameController..text = user.name,
// //       ),
// //       TextFormField(
// //         controller: emailController..text = user.email,
// //       ),
// //     ],
// //   ),
// // );
// //     }, icon: Icon(Icons.delete)),
//
//
//
//           );
//         },
//       ),

      // FutureBuilder<QuerySnapshot>(
      //   future: FirebaseFirestore.instance.collection("user").get(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator.adaptive());
      //     }
      //     var users = snapshot.data!.docs.map((e) =>
      //         model.User.fromMap(e.data() as Map<String, dynamic>)).toList();
      //     return ListView.builder(
      //       itemCount:users.length,
      //       itemBuilder: (BuildContext context, int index) {
      //         var user = users[index];
      //         return ListTile(
      //           title: Text(user.name),
      //           subtitle: Text(user.email),
      //         );
      //       },);
      //   },),

      // FutureBuilder<DocumentSnapshot>(
      //   future: FirebaseFirestore.instance.collection("user").doc(uid).get(),
      //   builder: (context, snapshot) {
      //   if(snapshot.connectionState==ConnectionState.waiting){
      //     return Center(child: CircularProgressIndicator.adaptive());
      //   }
      //   var user = model.User.fromMap(snapshot.data!.data()as Map<String, dynamic>);
      //
      //   return ListTile(
      //     title: Text(user.name),
      //     subtitle: Text(user.email),
      //   );
      // },)

      // FutureBuilder<QuerySnapshot>(
      //   future: FirebaseFirestore.instance.collection("user").get(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator.adaptive());
      //     }
      //     var users = snapshot.data!.docs
      //             .map((e) =>
      //                 model.User.fromMap(e.data() as Map<String, dynamic>))
      //             .toList();
      //         return ListView.builder(
      //           itemCount: users.length,
      //           itemBuilder: (BuildContext context, int index) {
      //             var user = users[index];
      //             return ListTile(
      //               title: Text(user.name),
      //               subtitle: Text(user.email),
      //             );
      //           },
      //         );
      //       },
      //
      // ),

      // FutureBuilder<DocumentSnapshot>(
      //   future: FirebaseFirestore.instance.collection("user").doc(uid).get(),
      //   builder: (context, snapshot) {
      //   if(snapshot.connectionState==ConnectionState.waiting){
      //   return Center(child: CircularProgressIndicator.adaptive());
      //   }
      //   var user = model.User.fromMap(snapshot.data!.data() as Map<String, dynamic>);
      //   return ListTile(title: Text(user.name),);
      // },),

      // FutureBuilder<QuerySnapshot>(
      //   future: FirebaseFirestore.instance.collection("user").get(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator.adaptive());
      //     }
      //     var users = snapshot.data!.docs
      //         .map((e) => User.fromMap(e.data() as Map<String, dynamic>))
      //         .toList();
      //     return ListView.builder(
      //       itemCount: users.length,
      //       itemBuilder: (BuildContext context, int index) {
      //         var user = users[index];
      //       return  ListTile(
      //           title: Text(user.name),
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
  Future<void> Updatenotification() async {
    String token = (await FCM.generateToken()??"");
   await FirebaseFirestore.instance.collection("user").doc(uid).update({"notification_token":token});
  }
// Future<void> Updatenotification() async {
// String token = (await FCM.generateToken()??"");
// await FirebaseFirestore.instance.collection("user").doc(uid).update({"notification_token": token});
// }
// Future<void> updateNotification() async {
//   String token = (await FCM.generateToken()) ?? "";
//   await FirebaseFirestore.instance
//       .collection("user")
//       .doc(uid)
//       .update({"notification_token": token});
// }

// void updateNotification() async {
//   String token = (await FCM.generateToken()) ?? '';
//   print(token);
//   await FirebaseFirestore.instance
//       .collection("user")
//       .doc(uid)
//       .update({"notification_token": token});
// }
// void updateNotification() async {
//   String token = (await FCM.generateToken()) ?? '';
//   await FirebaseFirestore.instance
//       .collection("user")
//       .doc(uid)
//       .update({"notification_token": token});
// }
//   Future<void> updateNotification() async {
//     String token = (await FCM.generateToken()) ?? "";
//     await FirebaseFirestore.instance
//         .collection("user")
//         .doc(uid)
//         .update({"notification_token": token});
//   }
}
