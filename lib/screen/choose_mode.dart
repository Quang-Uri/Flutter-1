import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:project_test/screen/regis_or_sign.dart';

class ChangeMode extends StatefulWidget {
  const ChangeMode({super.key});

  @override
  State<ChangeMode> createState() => _ChangeModeState();
}

class _ChangeModeState extends State<ChangeMode> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    var brightness = AdaptiveTheme.of(context).mode;
    bool isDarkMode = (brightness == AdaptiveThemeMode.light) ? false : true;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/a2.png"), // Thay "your_image.jpg" bằng tên hình ảnh của bạn
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(screen.width * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    AdaptiveTheme.of(context).toggleThemeMode();
                  },
                  child: Center(
                    child: Image.asset(
                      "assets/logo.png",
                      width: screen.width * 0.5,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "Choose Mode",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(screen.width * 0.1),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  AdaptiveTheme.of(context).setLight();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(16.0),
                                  backgroundColor:
                                  isDarkMode == false ? Color(0xFF1ED55F) : Colors.black,
                                ),
                                child: Icon(
                                  Icons.light_mode_outlined,
                                  color: Colors.white,
                                  size: 40.0,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Light Mode"),
                            ],
                          ),
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  AdaptiveTheme.of(context).setDark();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(16.0),
                                  backgroundColor:
                                  isDarkMode ? Color(0xFF1ED55F) : Colors.black,
                                ),
                                child: Icon(
                                  Icons.dark_mode_outlined,
                                  color: Colors.white,
                                  size: 40.0,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Dark Mode"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => OpeningScreen()),
                        );
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            Size(screen.width * 0.8, screen.height * 0.1)),
                        backgroundColor: MaterialStateProperty.all(Color(0xFF1ED55F)),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
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
