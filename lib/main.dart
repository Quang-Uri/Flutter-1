import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_test/screen/get_started.dart';

Future<void> main() async {
  // Đảm bảo đã khởi tạo FlutterBinding
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Firebase
  await Firebase.initializeApp();

  // Chạy ứng dụng
  runApp(MyApp());
}

// Ứng dụng chính
class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    // Chủ đề tối và sáng cho ứng dụng
    return AdaptiveTheme(
      light: ThemeData.light(useMaterial3: true),
      dark: ThemeData.dark(useMaterial3: true),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Adaptive Theme Demo',
        theme: theme,
        darkTheme: darkTheme,
        home: MyHomePage(),
      ),
    );
  }
}

// Trang chính của ứng dụng
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    // Hiển thị màn hình splash trong 5 giây trước khi chuyển đến trang GetStarted
    _loadSplashScreen();
  }

  _loadSplashScreen() async {
    await Future.delayed(Duration(seconds: 5));

    // Chuyển đến trang GetStarted
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => GetStartPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            // Chuyển đổi giữa chủ đề sáng và tối
            AdaptiveTheme.of(context).toggleThemeMode();
          },
          child: Image.asset("assets/logo.png", width: screen.width * 0.5),
        ),
      ),
    );
  }
}
