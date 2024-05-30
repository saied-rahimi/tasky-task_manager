// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:todo_app/core/api/api.dart';
import 'package:todo_app/core/pref/pref.dart';
import 'package:todo_app/core/widgets/custom_progress.dart';
import 'package:todo_app/core/widgets/text_widgts.dart';
import 'package:todo_app/login/ui/welcome_screen.dart';
import 'dart:math' as math;
import 'package:todo_app/pages/home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({required this.signUpOnTap, super.key});

  final VoidCallback signUpOnTap;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  bool isAuthorized = true;
  bool _isObscureText = true;
  bool _isLoading = false;
  late TextEditingController phoneController;
  late TextEditingController passwordController;

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
      // } else if (value.length < 8) {
      //   return 'Password must be at least 8 characters long';
    }
    return null;
  }

  _signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        final phoneNumber = phoneController.text;
        final password = passwordController.text.trim();
        final response = await Api().signInUser(phoneNumber, password);
        debugPrint('sign in response is: ${response.body}');
        if (response.statusCode == 401) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('The Password or phone number is incorrect!')),
          );
          setState(() {
            isAuthorized = false;
          });
        } else {
          final body = jsonDecode(response.body);
          final token = body['access_token'];
          final refreshToken = body['refresh_token'];
          debugPrint('sign in refreshToken is: $refreshToken');
          debugPrint('sign in token is: $token');
          await MyPref().setToke(token);
          await MyPref().setRefreshToke(refreshToken);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        }
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        debugPrint('sign in error is $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong, try again later')),
        );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    phoneController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const MediumTitleText(
              text: 'Sign in',
              align: TextAlign.start,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: IntlPhoneField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: '123-456-789',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                initialCountryCode: 'AF',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                validator: _validatePassword,
                controller: passwordController,
                obscureText: _isObscureText, // Toggle text visibility
                decoration: InputDecoration(
                  labelText: 'Enter your password',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(_isObscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscureText = !_isObscureText; // Toggle text visibility on button press
                      });
                    },
                  ),
                ),
              ),
            ),
            CustomButton(
              child: _isLoading
                  ? const CustomProgress()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SmallTitleText(text: 'Sign in', textColor: Colors.white, align: TextAlign.center),
                        const SizedBox(
                          width: 5,
                        ),
                        Transform.rotate(
                          angle: math.pi,
                          child: Image.asset(
                            'assets/icons/arrwo_left.png',
                            color: Colors.white,
                            height: 16,
                          ),
                        ),
                      ],
                    ),
              onTab: () {
                setState(() {
                  _isLoading = true;
                });
                _signIn();
              },
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Didn’t have any account? ',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: 'Sign Up here',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor, // Set the color to the primary color
                      decoration: TextDecoration.underline, // Underline the text
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = widget.signUpOnTap,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
