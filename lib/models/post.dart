import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final datePublished;
  final String postURL;
  final String profImage;
  final likes;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.postURL,
    required this.profImage,
    required this.likes, 
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'description': description,
        'uid': uid,
        'postId': postId,
        'profImage': profImage,
        'datePublished': datePublished,
        'postURL': postURL,
        'likes': likes,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      description: snapshot["description"],
      uid: snapshot["uid"],
      likes: snapshot["likes"],
      postId: snapshot["postId"],
      datePublished: snapshot["datePublished"],
      username: snapshot["username"],
      postURL: snapshot['postURL'],
      profImage: snapshot['profImage'], 
    );
  }

}
