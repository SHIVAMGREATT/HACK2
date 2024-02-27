import 'package:flutter/material.dart';
import 'package:vendors_app/authentication/auth_screen.dart';
import 'package:vendors_app/constants.dart';
import 'package:vendors_app/global/global.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.lightBlueAccent,
                Colors.amberAccent,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            )),
          ),
          title: Text(
            sharedPreferences!.getString("name")!,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        // body: Center(
        //   child: ElevatedButton(
        //     child: const Text("Logout"),
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: Colors.blue,
        //     ),
        //     onPressed: () {
        //       firebaseAuth.signOut().then((value) {
        //         Navigator.push(context,
        //             MaterialPageRoute(builder: (c) => const AuthScreen()));
        //       });
        //     },
        //   ),
        // ),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: kPrimaryColor,
              height: 500,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(kPadding),
                    constraints: BoxConstraints(maxWidth: kMaxWidth),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Green Grocer",
                              style: TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.w900,
                                color: kSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Mohan Yadav Cart",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Rating:4.5",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Image.asset(
                              "images/mohan yadav.jpg",
                              height: 130,
                              width: 190,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Shyam Cart",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Rating : 4.6",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Image.asset(
                              "images/shyam.jpg",
                              height: 130,
                              width: 190,
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Meena Devi",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "Rating :4.5",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Image.asset(
                              "images/meena devi.jpg",
                              height: 130,
                              width: 190,
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Sundar Lal Cart",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "Rating: 4.3",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Center(
                              child: Image.asset(
                                "images/sundar lal.jpg",
                                height: 110,
                                width: 190,
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Ramu Kaka",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "Rating : 4.7",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Image.asset(
                              "images/cauliflower.jpg",
                              height: 110,
                              width: 190,
                              fit: BoxFit.cover,
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
