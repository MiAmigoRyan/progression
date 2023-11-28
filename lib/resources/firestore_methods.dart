import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_flutter/models/post.dart';
import 'package:coach_flutter/models/event.dart';
import 'package:coach_flutter/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profileImage,
  ) async {
    String res = "some error ocured";
    try {
      String photoURL =
          await StorageMethods().uploadImageToStorage("posts", file, true);

      String postId = const Uuid().v1();

      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postURL: photoURL,
        profImage: profileImage,
        likes: [],
      );
      _firestore.collection('post').doc(postId).set(post.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
  return res;
  }

  Future<String> uploadAppointment(Event event) async {
    String res = "some error occurred";
    try {
      String appointmentId = const Uuid().v1();
      
      // Convert the Event object to a map
      Map<String, dynamic> appointmentData = {
        'title': event.title,
        'description': event.description,
        'from': event.from,
        'to': event.to,
        // Add other properties as needed
      };

      // Upload the appointment data to Firestore
      await _firestore.collection('appointments').doc(appointmentId).set(appointmentData);

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<List<Event>> getAppointments() async {
    List<Event> appointments = [];

    try {
      // Retrieve appointment data from Firestore
      QuerySnapshot querySnapshot = await _firestore.collection('appointments').get();

      // Convert the data to a list of Event objects
      appointments = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Event(
          title: data['title'],
          description: data['description'],
          from: (data['from'] as Timestamp).toDate(),
          to: (data['to'] as Timestamp).toDate(),
          tasks: data['tasks'],
          // Add other properties as needed
        );
      }).toList();
    } catch (e) {
      print(e.toString());
    }

    return appointments;
  }
}



