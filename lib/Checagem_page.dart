import 'dart:async';

import 'package:firebaseproject/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_page.dart';

class ChecagemPage extends StatefulWidget {
  const ChecagemPage({Key? key}) : super(key: key);

  @override
  State<ChecagemPage> createState() => _ChecagemPageState();
}

class _ChecagemPageState extends State<ChecagemPage> {

  StreamSubscription? streamSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   streamSubscription= FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context)=> LoginPage()));
      ;
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context)=> HomePage()));
      }
    });
  }

  @override
  void dispose(){
    streamSubscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator(),
      ),
    );
  }
}
