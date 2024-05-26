import 'package:flutter/material.dart';
import 'package:todo_app/login/ui/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Size screenSize;
  late ThemeData theme;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigate();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenSize = MediaQuery.of(context).size;
    theme = Theme.of(context);
  }

  _navigate() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        color: theme.primaryColor,
        child: Center(
          child: Image.asset(
            'assets/icons/tasky.png',
            width: screenSize.width * 0.6,
          ),
        ),
      ),
    );
  }
}
