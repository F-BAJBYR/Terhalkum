import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Import for localizations
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:terhalkum/Authentication/forgetpassword.dart';
import 'package:terhalkum/Authentication/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Login',
      home: LoginPage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('ar', ''), // Arabic
      ],
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _loginUser() async {
    if (_emailController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال البريد الإلكتروني وكلمة المرور')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://localhost/api/login.php'), // رابط API
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['status'] == 'success') {
          // Navigate based on user role (admin/user)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم تسجيل الدخول بنجاح')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseData['message'])),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل الاتصال بالخادم')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدث خطأ غير متوقع')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 50),
              const Text(
                'تسجيل دخول',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              _buildTextField(_emailController, Icons.email_outlined, 'الإيميل'),
              const SizedBox(height: 16),
              _buildTextField(_passwordController, Icons.lock_outline, 'كلمة المرور', obscureText: true),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ForgotPasswordPage()), // Action for "Forgot Password"
              );     
                },
                child: const Text(
                  'نسيت كلمة المرور؟',
                  style: TextStyle(color: Colors.blue),
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(height: 32),
              _buildLoginButton(),
              const SizedBox(height: 32),
              _buildSocialLoginOptions(),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterPage()), // Action for "New Account"
              );                                                        
                },
                child: const Text(
                  'ليس لديك أي حساب؟ مستخدم جديد',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField _buildTextField(TextEditingController controller, IconData icon, String hintText, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  ElevatedButton _buildLoginButton() {
    return ElevatedButton(
      onPressed: _loginUser,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 82, 58, 149),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        'تسجيل دخول',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }


Row _buildSocialLoginOptions() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      
      const SizedBox(width: 16),  // Space between text and icons
      _buildSocialIconButton(FontAwesomeIcons.apple, Colors.black),  // Apple Icon
      const SizedBox(width: 16),
      _buildSocialIconButton(FontAwesomeIcons.facebook, Colors.blue),  // Facebook Icon
      const SizedBox(width: 16),
      _buildSocialIconButton(FontAwesomeIcons.google, Colors.red),  // Google Icon
    ],
  );
}

Widget _buildSocialIconButton(IconData icon, Color backgroundColor) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: backgroundColor,
    ),
    padding: const EdgeInsets.all(12.0),  // Adjust padding for desired icon size
    child: FaIcon(
      icon,
      color: Colors.white,  // Icon color
    ),
  );
}


}
