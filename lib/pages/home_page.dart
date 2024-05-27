import 'package:flutter/material.dart';
import 'package:todo_app/core/widgets/text_widgts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              onPressed: () {},
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
                  padding: EdgeInsets.symmetric(vertical: 10),
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
                  isThreeLine: false,
                  minVerticalPadding: 10,
                  trailing: Image.asset(
                    'assets/icons/tree_dots.png',
                    height: 25,
                  ),
                  leading: Image.asset('assets/grocery_logo.png'),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SmallTitleText(text: 'Grocery Shopping'),
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
                      const Text('his application is designed for shopin '),
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
    );
  }
}
