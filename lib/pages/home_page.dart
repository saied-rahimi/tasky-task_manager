import 'package:flutter/material.dart';
import 'package:todo_app/core/utlis/item_json.dart';
import 'package:todo_app/core/widgets/item.dart';
import 'package:todo_app/core/widgets/text_widgts.dart';
import 'package:todo_app/pages/details_page/details_page.dart';
import 'package:todo_app/splash_screen.dart';
import '../core/pref/pref.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _progressIndex = 0;
  bool _isProgressActive = false;
  @override
  Widget build(BuildContext context) {
    final progressList = ['All', 'In progress', 'Waiting', 'Finished'];
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

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
              onPressed: () {
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
                    itemCount: progressList.length,
                    itemBuilder: (context, index) {
                      if (_progressIndex == index) {
                        _isProgressActive = true;
                      } else {
                        _isProgressActive = false;
                      }
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _progressIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            color: _isProgressActive ? theme.primaryColor : theme.primaryColor.withOpacity(0.3),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              child: SmallTitleText(
                                text: progressList[index],
                                textColor: Colors.white,
                              ),
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
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Item(item: items[index]);
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
}
