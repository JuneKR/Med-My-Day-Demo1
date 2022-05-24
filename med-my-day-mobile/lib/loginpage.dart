


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timezone/data/latest.dart' as tz;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late String _email = '';
  late String _password = '';
  FormType _formType = FormType.login;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Login'),
          backgroundColor: Colors.orange,
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: Column(
                children: buildInputs() + buildSubmit(),

              ),
            )));
  }

  List<Widget> buildInputs() {
    return [
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'MedMyDay',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 30),
          )),

      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Sign in',
            style: TextStyle(fontSize: 20, color: Colors.black),
          )),
      Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: TextFormField(
          validator: (value) =>
              value!.isEmpty ? 'Email can/t be empty' : null,
          onSaved: (value) => _email = value!,
          style: const TextStyle(
            color: Colors.black,
          ),
          controller: nameController,
          decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
              ),
              labelText: 'Email',
              labelStyle: TextStyle(
                color: Colors.grey,
              )),
        ),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: TextFormField(
          validator: (value) =>
              value!.isEmpty ? 'Password can/t be empty' : null,
          onSaved: (value) => _password = value!,
          style: const TextStyle(
            color: Colors.black,
          ),
          obscureText: true,
          controller: passwordController,
          decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
              ),
              labelText: 'Password',
              labelStyle: TextStyle(
                color: Colors.grey,
              )),
        ),
      ),
    ];
  }
  List<Widget> buildSubmit() {
    if(_formType == FormType.login) {
      return [
        Container(
          height: 15,
        ),
        Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: (){
                validateAndSubmit();
              },
              child: const Text('Login'),
            )),
        Container(
          height: 15,
        ),
        Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: moveToRegister,
              child: const Text('Register'),
            )),
      ];
    } else{
      return [
        Container(
          height: 15,
        ),
        Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
                primary: Colors.orange,
              ),
              onPressed: validateAndSubmit,
              child: const Text('Create an account'),
            )),
        Container(
          height: 15,
        ),
        Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: moveToLogIn,
              child: const Text('Have an account? Login!'),
            )),
      ];
    }
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    form?.save();
    if (form!.validate()) {
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if(_formType == FormType.login) {
          final UserCredential user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password));

          // print('Signed in: ${user.uid}');
          showL(context);

        } else{
          // final User user = (await FirebaseAuth.instance
          //     .createUserWithEmailAndPassword(email: _email, password: _password))
          // as User;
          final UserCredential user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: _email, password: _password));
          // print('Registered user : ${user.uid}');
          showC(context);

        }
      } catch (e) {
        showW(context);
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState?.reset();
    setState(() {
      _formType = FormType.register;
    });
  }
  void moveToLogIn(){
    formKey.currentState?.reset();
    setState(() {
      _formType = FormType.login;
    });
  }
  showL(BuildContext context){
    showDialog(context: context,
        builder: (BuildContext context){
      return const CupertinoAlertDialog(
        title: Icon(Icons.incomplete_circle),
        content: Text('Log In Successfully!'),
        actions: [
          CupertinoDialogAction(child: Text('OK')),
        ],
      );
        });
  }
  showC(BuildContext context){
    showDialog(context: context,
        builder: (BuildContext context){
          return const CupertinoAlertDialog(
            title: Icon(Icons.incomplete_circle),
            content: Text('Created Account! Successfully!'),
            actions: [
              CupertinoDialogAction(child: Text('OK')),
            ],
          );
        });
  }
  showW(BuildContext context){
    showDialog(context: context,
        builder: (BuildContext context){
          return const CupertinoAlertDialog(
            title: Icon(Icons.warning_rounded),
            content: Text('Wrong Username or Password or The format'),
            actions: [
              CupertinoDialogAction(child: Text('OK')),
            ],
          );
        });
  }

}
