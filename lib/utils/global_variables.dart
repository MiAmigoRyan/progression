
import 'package:coach_flutter/screens/add_post.dart';
import 'package:coach_flutter/screens/calendar_screen.dart';
import 'package:coach_flutter/screens/feed_screen.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;

const homeScreenItems = [
          FeedScreen(),
          CalendarScreen(),
          Text('search'),
          AddPostScreen(),
          Text('notifications'),
          Text('profile')
];