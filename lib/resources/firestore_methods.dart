import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_flutter/models/post.dart';
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
}
