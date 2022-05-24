import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medmyday_demo/imagedialog.dart';
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

  String _name = "";
  String _email = "";
  String _surname = "";

  @override
  void initState() {
    super.initState();
    showNoti();
    tz.initializeTimeZones();
    DocumentReference userName = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    userName.get().then((DocumentSnapshot ds) {
      _name = ds['name'];
      _email = ds['email'];
      _surname = ds['surname'];
    });

  }

  void showNoti() async {
    final uid = user!.uid;

    DocumentSnapshot variable =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    var reminder = 'Reminder!';
    var details = 'Hello Please check Your Appoitment and Information Below!';
    NotificationService().showNotification(0, reminder, details, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              height: 100,
              width: 320,
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage(
                      'assets/header.png',
                    ),
                    fit: BoxFit.cover),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(38, 10, 20, 0),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: const AssetImage(
                            'assets/mock.jpg',
                          ),
                          // backgroundColor: Colors.transparent,
                          child: GestureDetector(
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: (_) => const ImageDialog2());
                            },
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                            child: Container(
                              padding: const EdgeInsets.all(0.0),
                              child: const Text(
                                ("Welcome:"),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25, 10, 20, 0),
                            child: Container(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                ("Mr./Ms. $_name $_surname"),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(55, 10, 2, 20),
                            child: Container(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                ("Email:  $_email"),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                final uid = user!.uid;
                print('$uid');
                DocumentSnapshot variable = await FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .get();
                var reminder = 'Reminder!';
                var details =
                    "${"Do not forget your " + variable['druglist.title'] + " QTY: " + variable['druglist.amount'].toString()} with in two Days at MedMyDay Station!";
                NotificationService().showNotification(0, reminder, details, 1);
              },
              child: Container(
                height: 40,
                color: Colors.amber,
                child: const Center(
                  child: Text("My appointment"),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final uid = user?.uid.toString();
                DocumentSnapshot variable = await FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .get();
                var nameA =
                    "${"Name: " + variable['name'] + " Surname: " + variable['surname']}";
                var details = "Age: " + variable['age'].toString();
                var details2 = "Drug Title: " + variable['druglist.title'] + " with " + variable['druglist.amount'].toString() + " QTY ";

                showDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: const Icon(Icons.info_outline_rounded),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(nameA),
                        Text(details),
                        Text(details2),
                        Text('Please Click the Heart Icon to take the QR code for drug recieving')
                      ],
                    ),
                    actions: const [
                      CupertinoDialogAction(child: Text('Ok')),
                    ],
                  ),
                );
              },
              child: Container(
                height: 40,
                width: 200,
                color: Colors.amberAccent,
                child: const Center(
                  child: Text("My information"),
                ),
              ),
            ),
            Container(
              height: 15,
            ),
            CircleAvatar(
              radius: 150,
              backgroundImage: const AssetImage(
                'assets/QR_Code.png',
              ),
              // backgroundColor: Colors.transparent,
              child: GestureDetector(
                onTap: () async {
                  await showDialog(
                      context: context, builder: (_) => const ImageDialog());
                },
              ),
            ),
            Container(
              height: 15,
            ),
            Image.asset('assets/Check the Reminder!.png'),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.orangeAccent,
                minimumSize: const Size.fromHeight(50),
              ),
              icon: const Icon(Icons.arrow_back, size: 32),
              label: const Text(
                'Sign out',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () { FirebaseAuth.instance.signOut();
              showO(context);},
            )
          ],
        ),
      ),
    );
  }
  showO(BuildContext context){
    showDialog(context: context,
        builder: (BuildContext context){
          return const CupertinoAlertDialog(
            title: Icon(Icons.warning_rounded),
            content: Text('Signed Out Successfully'),
            actions: [
              CupertinoDialogAction(child: Text('OK')),
            ],
          );
        });
  }
}
