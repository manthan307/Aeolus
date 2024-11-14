import 'package:aeolus/Screens/Tabs/tasks.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  height: 40,
                  width: 40,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: Image.network(
                    "https://api.dicebear.com/9.x/notionists-neutral/png",
                    fit: BoxFit.cover,
                  ),
                ),
                const Icon(Iconsax.message)
              ],
            ),
          ),
          bottomNavigationBar: Container(
            margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).cardColor,
            ),
            child: TabBar(
                dividerHeight: 0,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                indicatorWeight: 9,
                splashBorderRadius: BorderRadius.circular(50),
                unselectedLabelColor: Colors.white,
                tabs: const [
                  Icon(Iconsax.task),
                  Icon(Iconsax.calendar),
                  Icon(Icons.newspaper),
                  Icon(Iconsax.clock),
                  Icon(Iconsax.heart)
                ]),
          ),
          body: const TabBarView(children: [
            Tasks(),
            Center(child: Text("calendar")),
            Center(child: Text("News")),
            Center(child: Text("clock")),
            Center(child: Text("Health")),
          ]),
        ));
  }
}
