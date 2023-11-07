import 'package:coach_flutter/models/user.dart' as model;
import 'package:coach_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  @override
  Widget build(BuildContext context)  {
   model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: Center(
        child: Text(user.username),

      ),
    );
  }
}
