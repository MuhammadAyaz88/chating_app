import 'package:chating_app/Screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:chating_app/Models/model_class.dart' as model;
class UserList extends StatelessWidget {
var uid=FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("user").where("id",isNotEqualTo: uid).snapshots(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              var users = snapshot.data!.docs.map((e) => model.User.fromMap(e.data() as Map<String, dynamic>))
                  .toList();
              return users.isEmpty
                  ? Center(
                child: Text("No uset"),
              )
                  : Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    var user = users[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(HomeScreen(user: user,));
                      },
                      child: ListTile(
                          title: Text(user.name),
                          subtitle: Text(
                            user.timestamp.toString(),
                            style: TextStyle(color: Colors.red),
                          ),
                          trailing: Text(user.email)),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
