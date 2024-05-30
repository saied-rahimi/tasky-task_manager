import 'package:flutter/material.dart';
import 'package:todo_app/core/model/truncate_text.dart';
import 'package:todo_app/core/widgets/text_widgts.dart';
import 'package:todo_app/pages/details_page/details_page.dart';

class Item extends StatelessWidget {
  const Item({required this.item, super.key});
  final Map item;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    late Color progressColor;
    if (item['progressStatus'] == 'Waiting') {
      progressColor = Colors.red;
    } else if (item['progressStatus'] == 'In Progress') {
      progressColor = theme.primaryColor;
    } else if (item['progressStatus'] == 'Finished') {
      progressColor = Colors.blueAccent;
    }

    late Color flagColor;
    if (item['priority'] == 'High') {
      flagColor = Colors.red;
    } else if (item['priority'] == 'Medium') {
      flagColor = theme.primaryColor;
    } else if (item['priority'] == 'Low') {
      flagColor = Colors.blueAccent;
    }
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
            text: truncateText(item['title'], 0.052, screenSize),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              color: progressColor.withOpacity(0.3),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 7,
              ),
              child: Text(
                item['progressStatus'],
                style: TextStyle(color: progressColor, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            truncateText(item['subtitle'], 0.09, screenSize),
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
                      color: flagColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      item['priority'],
                      style: TextStyle(color: flagColor),
                    )
                  ],
                ),
                Text(item['dedLine']),
              ],
            ),
          )
        ],
      ),
    );
  }
}
