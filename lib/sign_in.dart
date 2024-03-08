import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      // Handle sign in logic here
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HomePage(
                title: "StepUpYourDance",
              ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: SingleChildScrollView( // Wrap your content with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('logo.png'),
                    // Replace with your background image
                    fit: BoxFit.contain,
                    opacity: 10,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 30),
                        Text('StepUpYourDance', style: TextStyle(fontSize: 40,
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.bold)),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            // You can add more specific validation here, like checking the length
                            return null;
                          },
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            // You can add more specific validation here, like checking the length
                            return null;
                          },
                        ),
                        const SizedBox(height: 50.0),
                        Container(
                          child: ElevatedButton(
                            onPressed: _signIn,
                            child: Text('Sign In'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.pinkAccent,
                              // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        TextButton(
                          onPressed: () {
                            // Navigate to the forgot password screen
                          },
                          child: Text('Forgot Password?'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
