import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          title: Text('Login Page'),),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              label: Text('e-mail')
            ),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
                label: Text('password')
            ),
          ),
          ElevatedButton(onPressed: (){
            login();
          },
            child: Text('Entrar'),
          ),
        ],
      ),
    );
  }

  login() async{
    try{
     UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
      );
     if(userCredential != null){ Navigator.pushReplacement(
         context,
         MaterialPageRoute(
             builder: (context)=> HomePage(),),);}
    }on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuário não encontrado'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }else if(e.code == 'wrong_password'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sua Senha esta errada!'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }
}
