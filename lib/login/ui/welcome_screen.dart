
import 'package:flutter/material.dart';
import 'package:todo_app/login/ui/sign_in_page.dart';
import 'package:todo_app/login/ui/sign_up_page.dart';
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
  final PageController pageController = PageController();
  bool _keyboardVisible = false;
  bool _isSignUpPage = false;

  var _pageIndex = 0;

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
                controller: pageController,
                itemCount: 2,
                itemBuilder: (context, index) {
                  Widget mWidget = Container();
                  if (index == 0) {
                    mWidget = welcome(context, pageController);
                  } else {
                    _isSignUpPage
                        ? mWidget = SignUpPage(signInOnTap: () {
                            setState(() {
                              _isSignUpPage = false;
                            });
                          })
                        : mWidget = SignInPage(signUpOnTap: () {
                            setState(() {
                              _isSignUpPage = true;
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
