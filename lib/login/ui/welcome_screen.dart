import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:todo_app/core/widgets/drop_down.dart';
import 'package:todo_app/core/widgets/text_field.dart';
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
      padding: const EdgeInsets.symmetric(vertical: 30),
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
  final List<Map<String, dynamic>> mData = [
    {'liable': 'Name', 'hint': 'Enter your name', 'type': 'textInput', 'keyboardType': 'text'},
    {'liable': 'Phone Number', 'hint': 'Enter your Phone Number', 'type': 'textInput', 'keyboardType': 'phoneNum'},
    {'liable': 'Year of experience', 'hint': 'Enter your experience', 'type': 'textInput', 'keyboardType': 'int'},
    {
      'hint': 'Select Experience Level',
      'type': 'select',
      'experienceLevels': ['Beginner', 'Intermediate', 'Advanced', 'Expert'],
    },
    {'liable': 'Address', 'hint': 'Enter your address', 'type': 'textInput', 'keyboardType': 'text'},
    {'liable': 'Password', 'hint': 'Enter your password', 'type': 'textInput', 'keyboardType': 'password'},
  ];
  var _pageIndex = 0;
  final List<String> experienceLevels = ['Beginner', 'Intermediate', 'Advanced', 'Expert'];
  String? selectedLevel;
  List<TextEditingController> textControllerList = [];
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Add the observer
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    List.generate(
      mData.length,
      (index) => textControllerList.add(
        TextEditingController(),
      ),
    );
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
      body: CustomScrollView(
        physics: _pageIndex == 0 ? const NeverScrollableScrollPhysics() : null,
        slivers: [
          SliverAppBar(
            expandedHeight: screenSize.height * 0.5, // Adjust as needed
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return FlexibleSpaceBar(
                  background: Image.asset(
                    'assets/art.png',
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          SliverFillRemaining(
            fillOverscroll: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (page) {
                  setState(() {
                    _pageIndex = page;
                  });
                },
                controller: controller,
                itemCount: 2,
                itemBuilder: (context, index) {
                  Widget mWidget = Container();
                  if (index == 0) {
                    mWidget = welcome(context, controller);
                  } else {
                    _isRegsterPage
                        ? mWidget = signUp(context, controller, onTap: () {
                            setState(() {
                              _isRegsterPage = false;
                            });
                          })
                        : mWidget = signIn(context, controller, onTap: () {
                            setState(() {
                              _isRegsterPage = true;
                            });
                          });
                  }
                  return SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: mWidget,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding signUp(BuildContext context, PageController controller, {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  return DropDown(
                    hintText: mData[index]['hint'],
                    levelList: mData[index]['experienceLevels'],
                    onChanged: (value) {
                      setState(() {
                        selectedLevel = value!;
                      });
                    },
                    selectedLevel: selectedLevel,
                  );
                } else {
                  return TextInput(data: mData[index], controller: textControllerList[index]);
                }
              },
            ),
          ),
          CustomButton(
            child: Row(
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
              controller.animateToPage(
                2,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
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
                  recognizer: TapGestureRecognizer()..onTap = onTap,
                ),
              ],
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
              controller: passwordController,
              obscureText: _keyboardVisible, // Toggle text visibility
              decoration: InputDecoration(
                labelText: 'Enter your password',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(),
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
              controller.animateToPage(
                2,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
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
                  recognizer: TapGestureRecognizer()..onTap = onTap,
                ),
              ],
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
        const MediumTitleText(text: 'Task Management & \nTo-Do List', align: TextAlign.center),
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
