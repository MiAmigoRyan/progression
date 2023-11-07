import 'package:coach_flutter/providers/user_provider.dart';
import 'package:coach_flutter/responsive/mobile_screen_layout.dart';
import 'package:coach_flutter/responsive/responsive_layout_screen.dart';
import 'package:coach_flutter/responsive/web_screen_layout.dart';
import 'package:coach_flutter/screens/login_screen.dart';
import 'package:coach_flutter/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDSzE0JADmkrtDIGJuQjKNcz7zDUv3ujIk",
          appId: "1:949300976877:web:344fde44132e4d421cc0e4",
          messagingSenderId: "949300976877",
          projectId: "climbing-coach",
          storageBucket: "climbing-coach.appspot.com"),
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_)=> UserProvider()),
      ],
    
    
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Climbing Coach',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home: StreamBuilder(
        //runs only when user signs in or out
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          return const LoginScreen();
        },
      ),
    ),);
  }
}
