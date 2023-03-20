import 'package:custom_utils/custom_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helper/message.dart';

class ItemChat extends StatelessWidget {

  Message message;
  var uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Text("data");
    //   Align(
    //   alignment: message.sender_id == uid ? Alignment.centerRight
    //       : Alignment.centerLeft,
    //   child: Container(
    //     margin: EdgeInsets.only(right: 10),
    //     decoration: BoxDecoration(
    //         color: message.sender_id == uid
    //             ? Colors.blue
    //             : Colors.black12,
    //         borderRadius: BorderRadius.all(Radius.circular(7))),
    //     height: 6.4.h,
    //     width: 70.w,
    //     child: Padding(
    //       padding: EdgeInsets.only(left: 10, right: 8),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           SizedBox(
    //             height: 2,
    //           ),
    //           SizedBox(
    //             height: 2,
    //           ),
    //           Align(
    //               alignment: Alignment.topLeft,
    //               child: Text(
    //                 "${message.text}",
    //                 style: TextStyle(
    //                     color: message.sender_id == uid
    //                         ? Colors.white
    //                         : Colors.black),
    //               )),
    //           SizedBox(
    //             height: 6,
    //           ),
    //           Align(
    //             alignment: Alignment.centerRight,
    //             child: Text(
    //               timestampToDateFormat(message.timestamp,
    //                   "hh:mm - dd/MM/yyy"),
    //               style: TextStyle(
    //                   color: message.sender_id == uid
    //                       ? Colors.white
    //                       : Colors.black),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  ItemChat({
     required this.message,
  });
}
