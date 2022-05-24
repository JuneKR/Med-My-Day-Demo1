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
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    // Replace with actual values
    options: const FirebaseOptions(
        apiKey: "AIzaSyAoOz7-SguLNzIFMhOmMwjZztJPL2EXX2w",
        authDomain: "med-my-day.firebaseapp.com",
        projectId: "med-my-day",
        storageBucket: "med-my-day.appspot.com",
        messagingSenderId: "779535392041",
        appId: "1:779535392041:web:e620abe05a7ecb22022b38",
        measurementId: "G-QYQSD0X8D9"
    ),
  );
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


