import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecofriendly_banking_system/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;
  bool isCursorSelected = false;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return Center(
      child: Column(
        children: [
          Text(
            isLogin ? 'Login' : 'Register',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
    bool showLogo,
  ) {
    return Column(
      children: [
        if (showLogo)
          Container(
            width: isCursorSelected ? 175 : 300,
            height: isCursorSelected ? 175 : 300,
            child: Image.asset(
              'assets/images/logo.png', // Replace with your photo path
              fit: BoxFit.contain,
            ),
          ),
        SizedBox(height: 16),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: title,
          ),
          onTap: () {
            setState(() {
              isCursorSelected = true;
            });
          },
          onSubmitted: (value) {
            setState(() {
              isCursorSelected = false;
            });
          },
        ),
      ],
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? 'Login' : 'Register'),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register?' : 'Login?'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _entryField('Email', _controllerEmail, true),
            SizedBox(height: 16),
            _entryField('Password', _controllerPassword, false),
            SizedBox(height: 16),
            _errorMessage(),
            SizedBox(height: 16),
            _submitButton(),
            SizedBox(height: 16),
            _loginOrRegisterButton(),
          ],
        ),
      ),
    );
  }
}