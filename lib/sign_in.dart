import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_page.dart';




class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  void _signIn() {
    // Handle sign in logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Container(
      decoration: BoxDecoration(
      image: DecorationImage(
      image: AssetImage('logo.png'), // Replace with your background image
      fit: BoxFit.contain,

        opacity: 10,
      ),
      ),

      child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,

      children: <Widget>[
      // ... existing code ...
        SizedBox(height: 30),
      Text('StepUpYourDance', style: TextStyle(fontSize: 50,color: Colors.pinkAccent,fontWeight: FontWeight.bold ), ),
        SizedBox(height: 100),
      TextFormField(
      controller: _usernameController,
      decoration: InputDecoration(
      labelText: 'Username',
      prefixIcon: Icon(Icons.person),
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    ),
    ),
    SizedBox(height: 10),
    TextFormField(
    controller: _numberController,
    decoration: InputDecoration(
    labelText: 'Phone Number',
    prefixIcon: Icon(Icons.phone),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    ),
    ),
    keyboardType: TextInputType.phone,
    inputFormatters: <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(10),
    ],
    ),
        SizedBox(height: 10),
    TextFormField(
    controller: _emailController,
    decoration: InputDecoration(
    labelText: 'Email',
    prefixIcon: Icon(Icons.email),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    ),
    ),
    ),
        SizedBox(height: 10),
    TextFormField(
    controller: _passwordController,
    decoration: InputDecoration(
    labelText: 'Password',
    prefixIcon: Icon(Icons.lock),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    ),
    ),
    obscureText: true,
    ),
    const SizedBox(height:  50.0),
    Container(
    child: ElevatedButton(
    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => HomePage(
    title: "StepUpYourDance",
    ),
    ),
    );
    },
    child: Text('Sign In'),
    style: ElevatedButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: Colors.pinkAccent, // Text color
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
    ),
    ),
    ),
    ),
        SizedBox(height: 40),
            TextButton(
              onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomePage(
                 title: "StepUpYourDance",
               )));// Navigate to the forgot password screen
              },


              child: Text('Forgot Password?'),
            ),
          ],
        ),
      ),)
            );
  }
}
