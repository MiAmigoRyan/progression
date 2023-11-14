import 'package:coach_flutter/utils/colors.dart';
import 'package:coach_flutter/widgets/post_card.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Image.asset(
          'progression.png',
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.messenger_outline, color: primaryColor,),
          ),
        ],
      ),
   body: PostCard(),
    );
  }
}
