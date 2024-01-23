import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_test/screen/login.dart';
import 'package:quickalert/quickalert.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _fullname = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  bool _obscureText = true;

  // Phương thức đăng ký tài khoản sử dụng Email và Password
  Future<void> _registerWithEmailAndPassword() async {
    try {
      // Thực hiện đăng ký bằng Email và Password
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );

      User? user = userCredential.user;
      if (user != null) {
        // Lưu thông tin người dùng vào Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': _email.text,
          'full_name': _fullname.text,
        });

        // Hiển thị thông báo đăng ký thành công
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Tạo tài khoản thành công!',
          barrierDismissible: false,
          onConfirmBtnTap: () {
            // Chuyển đến trang đăng nhập sau khi đăng ký thành công
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      // Xử lý nếu có lỗi khi đăng ký
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Tạo tài khoản thất bại\nError: $e',
      );
      print('Đăng ký thất bại: $e');
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
                  "Register",
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
                // Ô nhập tên đầy đủ
                TextField(
                  controller: _fullname,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: false,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Full Name",
                  ),
                ),
                SizedBox(height: 10.0),
                // Ô nhập Email
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
                // Nút tạo tài khoản
                ElevatedButton(
                  onPressed: _registerWithEmailAndPassword,
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(screen.width * 0.8, screen.height * 0.08)),
                    backgroundColor: MaterialStateProperty.all(Color(0xFF1ED55F)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text(
                    'Create Account',
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
                // Đăng ký nếu đã có tài khoản
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Do You Have An Account? "),
                    InkWell(
                      onTap: (){
                        // Chuyển đến trang đăng nhập
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        "Sign In",
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
