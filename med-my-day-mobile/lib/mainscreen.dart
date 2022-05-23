import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medmyday_demo/notificationservice.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:firebase_auth/firebase_auth.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                DocumentSnapshot variable = await FirebaseFirestore.instance
                    .collection('drugs')
                    .doc('EcSfsqneMufsDnita3kW')
                    .get();
                var reminder = 'Reminder!';
                var details =
                    "${"Do not for goet your " + variable['title']} with in two Days at MedMyDay Station!";
                NotificationService().showNotification(1, reminder, details, 1);
              },
              child: Container(
                height: 40,
                width: 200,
                color: Colors.amber,
                child: const Center(
                  child: Text("My appointment"),
                ),
              ),
            ),
            Container(
              height: 15,
            ),

            Container(
              child: const Text(
                'Your QR code for Receiving your prescription!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            Container(
              height: 15,
            ),
            Container(
              color: Colors.orange,
              height: 40,
            ),
            Image.asset('assets/1.png'),
            Container(
              color: Colors.orange,
              height: 40,
            ),
            GestureDetector(
              onTap: () async {
                DocumentSnapshot variable = await FirebaseFirestore.instance
                    .collection('users')
                    .doc('UStThcEpYjMV7DDhNlKrexk3r7n1')
                    .get();
                var details =
                    "${"Name " + variable['name'] + " " + variable['surname'] + " " + variable['druglist.title']}";

                showDialog(
                      context: context, builder: (BuildContext context) => CupertinoAlertDialog(
                  title: Icon(Icons.info_outline_rounded),
                  content: Text(details + ""),
                  actions: const [
                    CupertinoDialogAction(child: Text('Ok')),
                  ],
                ),
                    );
              },
              child: Container(
                height: 40,
                width: 200,
                color: Colors.amber,
                child: const Center(
                  child: Text("My information"),
                ),
              ),
            ),
            Container(
              height: 15,
            ),
            Image.asset('assets/Check the Reminder!.png'),
            Container(
              height: 15,
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                minimumSize: const Size.fromHeight(50),
              ),
              icon: const Icon(Icons.arrow_back, size: 32),
              label: const Text(
                'Sign out',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () => FirebaseAuth.instance.signOut(),
            )
          ],
        ),
      ),
    );
  }
}
