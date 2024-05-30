// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:todo_app/core/api/api.dart';
import 'package:todo_app/core/widgets/custom_progress.dart';
import 'package:todo_app/core/widgets/drop_down.dart';
import 'package:todo_app/core/widgets/text_field.dart';
import 'package:todo_app/core/widgets/text_widgts.dart';
import 'package:todo_app/login/ui/welcome_screen.dart';
import 'dart:math' as math;

import '../../pages/home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.signInOnTap});
  final VoidCallback signInOnTap;
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  List<TextEditingController> textControllerList = [];
  final _formKey = GlobalKey<FormState>();
  final bool duplicateNum = false;
  bool _isValidated = true;
  bool _isLoading = false;

  final List<Map<String, dynamic>> mData = [
    {'liable': 'Name', 'hint': 'Enter your name', 'type': 'textInput', 'keyboardType': 'text'},
    {'liable': 'Phone Number', 'hint': 'Enter your Phone Number', 'type': 'textInput', 'keyboardType': 'phoneNum'},
    {'liable': 'Year of experience', 'hint': 'Enter your experience', 'type': 'textInput', 'keyboardType': 'int'},
    {
      'hint': 'Select Experience Level',
      'type': 'select',
      'experienceLevels': ['fresh', 'junior', 'midLevel', 'senior'],
    },
    {'liable': 'Address', 'hint': 'Enter your address', 'type': 'textInput', 'keyboardType': 'text'},
    {'liable': 'Password', 'hint': 'Enter your password', 'type': 'textInput', 'keyboardType': 'password'},
  ];

  final List<String> experienceLevels = ['Beginner', 'Intermediate', 'Advanced', 'Expert'];
  String? selectedLevel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List.generate(
      mData.length,
      (index) => textControllerList.add(
        TextEditingController(),
      ),
    );
  }

  String? _validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? _validatePhone(PhoneNumber? phone) {
    if (phone == null || phone.number.isEmpty) {
      return 'This field is required';
    } else {
      if (duplicateNum) {
        return 'This number is used before';
      }
    }
    // Add more phone number validation if needed
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(value)) {
      return 'Password must contain both letters and numbers';
    }
    return null;
  }

  String? _validateExperience(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if (int.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  final token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjU4NDUyMWVkNWFhMTk0ZmFjMDNiZDUiLCJpYXQiOjE3MTcwNjA4OTcsImV4cCI6MTcxNzA2MTQ5N30.Hd7NpOk2oAGhs9HDDwWC6yT_Kn1cSeJpmM80Wl-1_2I","refresh_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjU4NDUyMWVkNWFhMTk0ZmFjMDNiZDUiLCJpYXQiOjE3MTcwNjA4OTd9.V_77IKxqnt-aHesRrpviGQfjf9yjNpBBziyBlEMKJSs';
  _signUp(bool isValidated) async {
    if (_formKey.currentState!.validate() && isValidated) {
      try {
        final name = textControllerList[0].text;
        final phoneNumber = textControllerList[1].text;
        final expYear = int.tryParse(textControllerList[2].text);
        final address = textControllerList[4].text;
        final password = textControllerList[5].text.trim();
        final response = await Api().signUpUser(phoneNumber, password, name, expYear ?? 0, address, selectedLevel ?? 'fresh');

        if (response.statusCode == 422) {
          // Phone number already used
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Phone number already used')),
          );
        } else {
          // Successfully registered
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Successfully registered')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        debugPrint('sign up error is $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong, try again later')),
        );
      }
    }
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
              text: 'Sign up',
              align: TextAlign.start,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 450,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: mData.length,
                itemBuilder: (context, index) {
                  if (mData[index]['type'] == 'select') {
                    return LevelDropDown(
                      isValidated: _isValidated,
                      hintText: mData[index]['hint'],
                      levelList: mData[index]['experienceLevels'],
                      onChanged: (value) {
                        setState(() {
                          selectedLevel = value!;
                          _isValidated = true;
                        });
                      },
                      selectedLevel: selectedLevel,
                    );
                  } else {
                    return TextInput(
                      data: mData[index],
                      controller: textControllerList[index],
                      validator: mData[index]['keyboardType'] == 'phoneNum'
                          ? null
                          : mData[index]['keyboardType'] == 'password'
                              ? _validatePassword
                              : mData[index]['keyboardType'] == 'int'
                                  ? _validateExperience
                                  : _validateText,
                      intValidator: mData[index]['keyboardType'] == 'phoneNum' ? _validatePhone : null,
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              child: _isLoading
                  ? const CustomProgress()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SmallTitleText(text: 'Sign up', textColor: Colors.white, align: TextAlign.center),
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
                if (selectedLevel == null) {
                  setState(() {
                    _isValidated = false;
                  });
                } else {
                  setState(() {
                    _isLoading = true;
                    _isValidated = true;
                  });
                }

                _signUp(_isValidated);
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const HomePage(),
                //   ),
                // );
              },
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Already have any account?  ',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: 'Sign in',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor, // Set the color to the primary color
                      decoration: TextDecoration.underline, // Underline the text
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = widget.signInOnTap,
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
