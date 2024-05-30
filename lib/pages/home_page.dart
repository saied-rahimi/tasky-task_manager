import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/core/api/api.dart';
import 'package:todo_app/core/widgets/text_widgts.dart';
import 'package:todo_app/pages/details_page/details_page.dart';
import 'package:todo_app/splash_screen.dart';
import '../core/pref/pref.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    debugPrint('width size is: ${screenSize.width * 0.052} ');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Image.asset(
            'assets/icons/tasky.png',
            height: 30,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 13),
            child: IconButton(
              icon: Image.asset('assets/icons/avatar.png'),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 13),
            child: IconButton(
              icon: Image.asset('assets/icons/log_out.png'),
              onPressed: () async {
                final token = await MyPref().getToke();
                final response = await Api().logOut(token!);
                final body = await jsonDecode(response.body);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SplashScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SmallTitleText(
                  text: 'My Tasks',
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          color: theme.primaryColor,
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            child: SmallTitleText(
                              text: 'All',
                              textColor: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailsPage(),
                      ),
                    );
                  },
                  isThreeLine: false,
                  minVerticalPadding: 10,
                  trailing: Column(
                    children: [
                      Image.asset(
                        'assets/icons/tree_dots.png',
                        height: 25,
                      ),
                    ],
                  ),
                  leading: Image.asset(
                    'assets/grocery_logo.png',
                    width: 70,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallTitleText(
                        text: truncateText('Grocery Shopping sdddsss', 0.052, screenSize),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(7)),
                          color: Colors.red.withOpacity(0.7),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 7,
                          ),
                          child: Text(
                            'Waiting',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        truncateText('This application is designed for shoppinng and grocerying', 0.09, screenSize),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/icons/flag.png',
                                  height: 20,
                                  color: theme.primaryColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'low',
                                  style: TextStyle(color: theme.primaryColor),
                                )
                              ],
                            ),
                            const Text('2024/06/12'),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () async {
              final token = await MyPref().getToke();
              debugPrint('token is: $token');
            },
            child: Container(
                height: 55,
                decoration: const BoxDecoration(
                  color: Color(0xffd3c3f8),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/icons/qr_code.png',
                )),
          ),
          InkWell(
            onTap: () async {
              await MyPref().setToke('sdfeee');
            },
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 10,
                    spreadRadius: 0.2,
                    offset: Offset(0, 5),
                  )
                ],
                color: theme.primaryColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String truncateText(String text, double maxWidth, Size screenSize) {
    final maxLength = (screenSize.width * maxWidth).toInt();
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength - 4)}...';
    } else {
      return text;
    }
  }
}
