import 'package:flutter/material.dart';
import 'package:todo_app/core/widgets/drop_down.dart';
import 'package:todo_app/core/widgets/text_widgts.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 70,
          leading: IconButton(
            icon: Image.asset(
              'assets/icons/arrwo_left.png',
              width: 25,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            PopupMenuButton<String>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.white,
              onSelected: (String result) {
                if (result == 'Edit') {
                  // Handle edit action
                } else if (result == 'Delete') {
                  // Handle delete action
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Edit',
                  child: Text(
                    'Edit',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem<String>(
                  value: 'Delete',
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),

            // InkWell(
            //   onTap: () {},
            //   child: Image.asset(
            //     'assets/icons/tree_dots.png',
            //     height: 25,
            //   ),
            // ),
          ],
          title: const MediumTitleText(
            text: 'Task details',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset('assets/grocery_logo.png'),
                const MediumTitleText(text: 'Grocery Shopping App'),
                const ParagraphText(
                  '''This application is designed for super shops. By using this application they can enlist all their products in one place and can deliver. Customers will get a one-stop solution for their daily shopping.''',
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomContainer(
                  theme: theme,
                  icon: Image.asset('assets/icons/calendar.png'),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'End Date',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '30 June 2022',
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomDropDown(
                  hintText: 'hint',
                  dropItems: const ['first', 'second'],
                  onChanged: (value) {},
                  selectedItem: 'first',
                ),
                CustomDropDown(
                  leadingIcon: Image.asset(
                    'assets/icons/flag.png',
                    height: 30,
                  ),
                  hintText: 'hint',
                  dropItems: const ['Inprogress', 'second'],
                  onChanged: (value) {},
                  selectedItem: 'Inprogress',
                ),
                Image.asset('assets/qr_code.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.theme,
    required this.child,
    required this.icon,
  });

  final ThemeData theme;
  final Widget child;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 60,
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.2),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          child,
          icon,
        ],
      ),
    );
  }
}
