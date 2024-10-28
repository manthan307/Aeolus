import 'package:aeolus/Screens/Tabs/tasks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
              actions: const [
                Icon(CupertinoIcons.chat_bubble),
                SizedBox(
                  width: 15,
                )
              ],
              leading: Padding(
                  padding: const EdgeInsets.all(5),
                  child: InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      backgroundImage: Image.network(
                        "https://api.dicebear.com/9.x/lorelei/jpg",
                        fit: BoxFit.cover,
                      ).image,
                      // radius: 10,
                    ),
                  ))),
          bottomNavigationBar: Container(
            height: 70,
            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 4,
                      blurStyle: BlurStyle.outer,
                      color: Colors.black26,
                      offset: Offset(5, 5),
                      spreadRadius: 10)
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: const TabBar(
                indicatorWeight: 9,
                unselectedLabelColor: Colors.black,
                // labelColor: tabbarcolor,
                splashBorderRadius: BorderRadius.all(Radius.circular(50)),
                // overlayColor: WidgetStateProperty.all<Color>(
                //     tabbarcolor.withOpacity(0.2)),
                // indicatorColor: tabbarcolor,
                tabs: [
                  Tab(icon: Icon(CupertinoIcons.square_list)),
                  Tab(icon: Icon(CupertinoIcons.calendar)),
                  Tab(icon: Icon(CupertinoIcons.clock)),
                  Tab(icon: Icon(CupertinoIcons.heart)),
                ]),
          ),
          body: TabBarView(
            children: [
              Tasks(),
              const Icon(Icons.directions_transit),
              const Icon(Icons.directions_bike),
              const Icon(Icons.directions_bike),
            ],
          ),
        ));
  }
}
