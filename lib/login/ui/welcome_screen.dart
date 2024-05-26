import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'dart:math' as math;
import '../../core/widgets/text_widgts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onTab,
    super.key,
    required this.child,
  });
  final VoidCallback onTab;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor, // Set the primary color
          minimumSize: const Size(double.infinity, 60), // Set the button height
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Set the border radius
          ),
        ),
        onPressed: onTab,
        child: child,
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with WidgetsBindingObserver {
  final PageController controller = PageController();
  bool _keyboardVisible = false;
  bool _isRegsterPage = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Add the observer
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Remove the observer
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = WidgetsBinding.instance.platformDispatcher.views.first.viewInsets.bottom;
    final newValue = bottomInset > 0.0;
    if (newValue != _keyboardVisible) {
      setState(() {
        _keyboardVisible = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            top: _keyboardVisible ? -screenSize.height * 0.2 : 0, // Adjust the value based on your needs
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/art.png',
              width: screenSize.width,
              fit: BoxFit.fitWidth,
            ),
          ),
          PageView.builder(
            controller: controller,
            itemCount: 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return welcome(context, controller);
              } else {
                return _isRegsterPage
                    ? signUp(context, controller, onTap: () {
                        setState(() {
                          _isRegsterPage = false;
                        });
                      })
                    : signIn(context, controller, onTap: () {
                        setState(() {
                          _isRegsterPage = true;
                        });
                      });
              }
            },
          ),
        ],
      ),
    );
  }

  Padding signUp(BuildContext context, PageController controller, {required VoidCallback onTap}) {
    final mData = [
      {'liable': 'Name', 'placeHolder': 'Enter your name', 'type': 'text'}
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const TitleText(
            text: 'Sign up',
            align: TextAlign.start,
          ),
          const SizedBox(
            height: 20,
          ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(vertical: 10),
          //   child: IntlPhoneField(
          //     decoration: InputDecoration(
          //       labelText: '123-456-789',
          //       border: OutlineInputBorder(
          //         borderSide: BorderSide(),
          //         borderRadius: BorderRadius.all(Radius.circular(10)),
          //       ),
          //     ),
          //     initialCountryCode: 'AF',
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 10),
          //   child: TextFormField(
          //     obscureText: _keyboardVisible, // Toggle text visibility
          //     decoration: InputDecoration(
          //       labelText: 'Enter your password',
          //       border: OutlineInputBorder(
          //         borderSide: const BorderSide(),
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       suffixIcon: IconButton(
          //         icon: Icon(_keyboardVisible ? Icons.visibility : Icons.visibility_off),
          //         onPressed: () {
          //           setState(() {
          //             _keyboardVisible = !_keyboardVisible; // Toggle text visibility on button press
          //           });
          //         },
          //       ),
          //     ),
          //   ),
          // ),
          CustomButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TitleText(text: 'Sign in', textColor: Colors.white, align: TextAlign.center),
                const SizedBox(
                  width: 10,
                ),
                Transform.rotate(
                  angle: math.pi,
                  child: Image.asset(
                    'assets/icons/arrwo_left.png',
                    color: Colors.white,
                    height: 24,
                  ),
                ),
              ],
            ),
            onTab: () {
              controller.animateToPage(
                2,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Didn’t have any account? ',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: 'Sign Up here',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor, // Set the color to the primary color
                      decoration: TextDecoration.underline, // Underline the text
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = onTap,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding signIn(BuildContext context, PageController controller, {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const TitleText(
            text: 'Login',
            align: TextAlign.start,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: IntlPhoneField(
              decoration: const InputDecoration(
                labelText: '123-456-789',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              initialCountryCode: 'AF',
              onChanged: (phone) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              obscureText: _keyboardVisible, // Toggle text visibility
              decoration: InputDecoration(
                labelText: 'Enter your password',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: Icon(_keyboardVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _keyboardVisible = !_keyboardVisible; // Toggle text visibility on button press
                    });
                  },
                ),
              ),
            ),
          ),
          CustomButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TitleText(text: 'Sign in', textColor: Colors.white, align: TextAlign.center),
                const SizedBox(
                  width: 10,
                ),
                Transform.rotate(
                  angle: math.pi,
                  child: Image.asset(
                    'assets/icons/arrwo_left.png',
                    color: Colors.white,
                    height: 24,
                  ),
                ),
              ],
            ),
            onTab: () {
              controller.animateToPage(
                2,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Didn’t have any account? ',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: 'Sign Up here',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor, // Set the color to the primary color
                      decoration: TextDecoration.underline, // Underline the text
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = onTap,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column welcome(BuildContext context, PageController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const TitleText(text: 'Task Management & \nTo-Do List', align: TextAlign.center),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'This productive tool is designed to help \nyou better manage your task \nproject-wise conveniently!',
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.7,
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor, // Set the primary color
              minimumSize: const Size(double.infinity, 60), // Set the button height
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Set the border radius
              ),
            ),
            onPressed: () => controller.animateToPage(
              2,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Let’s Start',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Transform.rotate(
                  angle: math.pi,
                  child: Image.asset(
                    'assets/icons/arrwo_left.png',
                    color: Colors.white,
                    height: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 70,
        ),
      ],
    );
  }
}
