import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignupScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  Future<void> _signUpWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } catch (e) {
        print('Error signing up: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);

    return Scaffold(
      backgroundColor: currentTheme.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_alert,
                    color: Color.fromARGB(255, 132, 9, 9),
                    size: 100,
                  ),
                  SizedBox(height: 25),
                  Text(
                    'Welcome, New User!',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'sans-serif',
                      fontWeight: FontWeight.bold,
                      color: currentTheme.brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: currentTheme.brightness == Brightness.dark
                            ? Colors.grey[800] // Set to dark background color
                            : Colors.grey[200], // Set to light background color
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none, // No border
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: currentTheme.brightness == Brightness.dark
                            ? Colors.grey[800] // Set to dark background color
                            : Colors.grey[200], // Set to light background color
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none, // No border
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Email',
                      ),
                      validator: _validateEmail,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: currentTheme.brightness == Brightness.dark
                            ? Colors.grey[800] // Set to dark background color
                            : Colors.grey[200], // Set to light background color
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none, // No border
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Password',
                      ),
                      validator: _validatePassword,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: GestureDetector(
                      onTap: _signUpWithEmailAndPassword,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 132, 9, 9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'sans-serif',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10), // Add some space
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          color: currentTheme.brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          fontSize: 16,
                          fontFamily: 'sans-serif',
                        ),
                        children: [
                          TextSpan(
                            text: 'Login here.',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontFamily: 'sans-serif',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
