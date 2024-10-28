import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  PageController controller = PageController();
  int selectedpage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Widget,
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: Row(
              children: [
                Container(
                  width: selectedpage == 0 ? 25 : 12,
                  height: 10,
                  margin: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                  decoration: const BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                ),
                Container(
                  width: selectedpage == 1 ? 25 : 12,
                  height: 10,
                  margin: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                  decoration: const BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                ),
                Container(
                  width: selectedpage == 2 ? 25 : 12,
                  height: 10,
                  margin: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                  decoration: const BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
              child: PageView(
            controller: controller,
            onPageChanged: (value) => {
              setState(() {
                selectedpage = value;
              })
            },
            children: const [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(image: AssetImage("assets/img/Login.png")),
                  Text(
                    "Save Your Time Using Aeolus!",
                    style: TextStyle(fontSize: 44, fontFamily: "Jaro"),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(image: AssetImage("assets/img/productive.png")),
                  Text(
                    "Stay Productive Using Aeolus!",
                    style: TextStyle(fontSize: 44, fontFamily: "Jaro"),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(image: AssetImage("assets/img/fire.png")),
                  Text(
                    "Maintain Your Health!",
                    style: TextStyle(fontSize: 44, fontFamily: "Jaro"),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ],
          )),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: ElevatedButton.icon(
                onPressed: () {},
                label: const Text(
                  "Continue with Google",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                icon: Image.asset(
                  "assets/img/google_logo.png",
                  height: 35,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xfff2f2f2),
                  overlayColor: Colors.black26,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                )),
          ),
          // const SizedBox(
          //   height: 80,
          // )
        ],
      ),
    ));
  }
}
