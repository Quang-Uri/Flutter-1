import 'package:flutter/material.dart';
import 'package:project_test/screen/register.dart';

import 'login.dart';

class OpeningScreen extends StatefulWidget {
  const OpeningScreen({Key? key});

  @override
  State<OpeningScreen> createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/a3.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(screen.width * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: Image.asset(
                    "assets/logo.png",
                    width: screen.width * 0.5,
                  ),
                ),
                SizedBox(
                  height: screen.height * 0.1,
                ),
                Text(
                  "Enjoy Listening to Music",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screen.width * 0.05),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterPage()),
                        );
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(
                            screen.width * 0.35,
                            screen.height * 0.075)),
                        backgroundColor: MaterialStateProperty.all(
                            Color(0xFF1ED55F)),
                        foregroundColor: MaterialStateProperty.all(
                            Colors.white),
                      ),
                      child: Text(
                        'Register',
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(
                            screen.width * 0.35,
                            screen.height * 0.075)),
                        backgroundColor:
                        MaterialStateProperty.all(Color(0xFF1C1B1F)),
                        foregroundColor: MaterialStateProperty.all(
                            Colors.white),
                      ),
                      child: Text(
                        'Sign In',
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
