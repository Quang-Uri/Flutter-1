import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_test/screen/home_page.dart';
import 'package:project_test/screen/register.dart';
import 'package:quickalert/quickalert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  bool _obscureText = true;

  Future<void> _signInWithEmailAndPassword() async {
    try {
      // Đăng nhập bằng Email và Password
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );

      User? user = userCredential.user;
      if (user != null) {
        // Lấy dữ liệu người dùng từ Firestore
        DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (snapshot.exists) {
          var userData = snapshot.data();
          String? fullName = userData?['full_name'];

          // Hiển thị thông báo đăng nhập thành công
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: 'Đăng nhập thành công!\nChào $fullName',
            barrierDismissible: false,
            onConfirmBtnTap: () {
              // Chuyển đến trang chính sau khi đăng nhập
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePageScreen()),
              );
            },
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      // Xử lý nếu có lỗi khi đăng nhập
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Đăng nhập thất bại\nError: $e',
      );
      print('Đăng nhập thất bại: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screen.width * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: () {
                    // Chuyển đổi giữa chủ đề sáng và tối
                    AdaptiveTheme.of(context).toggleThemeMode();
                  },
                  child: Center(
                    child: Image.asset(
                      "assets/logo.png",
                      width: screen.width * 0.3,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  "Sign In",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Login as account "),
                    Text(
                      "Spotify",
                      style: TextStyle(color: Color(0xFF1ED55F)),
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                // Ô nhập Email
                SizedBox(height: 10.0),
                TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: false,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Enter Email",
                  ),
                ),
                SizedBox(height: 10.0),
                // Ô nhập Password
                TextField(
                  controller: _password,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: false,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                // Nút đăng nhập
                ElevatedButton(
                  onPressed: _signInWithEmailAndPassword,
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(screen.width * 0.8, screen.height * 0.08)),
                    backgroundColor: MaterialStateProperty.all(Color(0xFF1ED55F)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                // Đường kẻ hoặc
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        height: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        height: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                // Nút đăng nhập bằng Google và Apple
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/google.png",
                      width: screen.width * 0.15,
                    ),
                    Image.asset(
                      "assets/apple.png",
                      width: screen.width * 0.15,
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                // Đăng ký nếu chưa có tài khoản
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Do You No Account? "),
                    InkWell(
                      onTap: () {
                        // Chuyển đến trang đăng ký
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterPage()),
                        );
                      },
                      child: Text(
                        "Register here",
                        style: TextStyle(color: Color(0xFF032F81)),
                      ),
                    )
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
