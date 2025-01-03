import 'package:aeolus/Screens/Tabs/tasks.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

// Home screen with a tab controller and bottom navigation bar.
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
              const Icon(Iconsax.message) // Icon for messages.
            ],
          ),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: const Color(0xffd6d0f0),
          ),
          child: TabBar(
            dividerHeight: 0,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            indicatorWeight: 9,
            splashBorderRadius: BorderRadius.circular(50),
            unselectedLabelColor: Colors.black.withOpacity(0.8),
            tabs: const [
              Icon(Iconsax.task), // Tab icon for tasks.
              Icon(Iconsax.calendar), // Tab icon for calendar.
              Icon(Iconsax.clock), // Tab icon for clock.
              Icon(Iconsax.heart) // Tab icon for health.
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Tasks(), // Tasks tab.
            Center(child: Text("calendar")), // Calendar tab.
            Center(child: Text("clock")), // Clock tab.
            Center(child: Text("Health")), // Health tab.
          ],
        ),
      ),
    );
  }
}
