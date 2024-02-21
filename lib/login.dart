import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  Future<void> _signInWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        // Navigate to the home screen or handle authentication success
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } catch (e) {
        // Handle authentication failure (show error message, etc.)
        print('Error signing in: $e');
        setState(() {
          _errorMessage = 'Invalid email or password. Please try again.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);

    return Scaffold(
      backgroundColor: currentTheme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_alert,
              color: Color.fromARGB(255, 132, 9, 9),
              size: 100,
            ),
            SizedBox(height: 40),
            Text(
              'EmergenSee',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                fontFamily: 'sans-serif',
                color: currentTheme.brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            Text(
              'Welcome back, you\'ve been missed!',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'sans-serif',
                color: currentTheme.brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      style: TextStyle(
                        color: currentTheme.textTheme.bodyText1?.color,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: currentTheme.brightness == Brightness.dark
                            ? Colors.grey[800] // Set to dark background color
                            : Colors.grey[200], // Set to light background color
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: currentTheme.hintColor,
                        ),
                        contentPadding: EdgeInsets.all(20), // Adjust padding as needed
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none, // No border
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      style: TextStyle(
                        color: currentTheme.textTheme.bodyText1?.color,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: currentTheme.brightness == Brightness.dark
                            ? Colors.grey[800] // Set to dark background color
                            : Colors.grey[200], // Set to light background color
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: currentTheme.hintColor,
                        ),
                        contentPadding: EdgeInsets.all(20), // Adjust padding as needed
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none, // No border
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: _signInWithEmailAndPassword,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 132, 9, 9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Login',
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
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        // Add logic for navigating to the login screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupScreen()),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(
                            color: currentTheme.brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                            fontFamily: 'sans-serif',
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign up here.',
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
                    // Display error message if authentication fails
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
