import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:project_test/screen/choose_mode.dart';

class GetStartPage extends StatefulWidget {
  const GetStartPage({super.key});

  @override
  State<GetStartPage> createState() => _GetStartPageState();
}

class _GetStartPageState extends State<GetStartPage> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/a1.png"), // Thay "your_image.jpg" bằng tên hình ảnh của bạn
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
                  onTap: (){
                    AdaptiveTheme.of(context).toggleThemeMode();
                  },
                  child: Center(
                      child: Image.asset(
                        "assets/logo.png",
                        width: screen.width * 0.5,
                      )),
                ),
                Column(
                  children: [
                    Text("Enjoy Listening to Music", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24
                    ),),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: screen.width * 0.05),
                      child: Text(
                        "Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit. Sagittis\nenim purus sed phasellus. Cursus\nornare id scelerisque aliquam.",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey
                        ),textAlign: TextAlign.center,),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => ChangeMode()),
                        );
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(screen.width* 0.8, screen.height * 0.1)), // Đặt kích thước tối thiểu
                        backgroundColor: MaterialStateProperty.all(Color(0xFF1ED55F)), // Màu nền xanh
                        foregroundColor: MaterialStateProperty.all(Colors.white), // Màu chữ trắng
                      ),
                      child: Text('Get Started', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),),
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
