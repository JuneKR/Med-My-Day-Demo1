import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medmyday_demo/mainscreen.dart';
import 'package:medmyday_demo/notificationservice.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'loginpage.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){
  return MaterialApp(
    home: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return const MainScreen();
        }
        else {
          return const LoginPage();
        }
      },
    ),
  );
  }
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Flutter Demo',
  //     initialRoute: '/',
  //     routes: {
  //       '/': (context) => const LoginPage(),
  //       '/mainScreen': (context) => const MainScreen(),
  //     },
  //   );
  // }
}



