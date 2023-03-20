import 'package:firebase_database/firebase_database.dart';
import 'message.dart';


var chatRef = FirebaseDatabase.instance.ref("chat");
Future<void> sendMessage(Message message) async {
  await chatRef.child("${message.sender_id}/inbox/${message.receiver_id}/inbox/${message.id}").set(message.toMap());
  await chatRef.child("${message.receiver_id}/inbox/${message.sender_id}/inbox/${message.id}").set(message.toMap())
      .catchError((error){
        throw error.toString();
  });
}

