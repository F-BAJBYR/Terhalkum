import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Import for localizations
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Registration',
      home: RegisterPage(),
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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isChecked = false;

  Future<void> _registerUser() async {
    // Check for empty fields
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى ملء جميع الحقول')),
      );
      return;
    }

    // Check for matching passwords
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('كلمات المرور غير متطابقة')),
      );
      return;
    }

    // Attempt to register user
    try {
  final response = await http.post(
    Uri.parse('https://localhost/api/register.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'fullName': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'phone': _phoneController.text.trim(),
      'password': _passwordController.text.trim(),
    }),
  );

  // Print response status code for debugging
  if (kDebugMode) {
    print('Response status: ${response.statusCode}');
  }
  if (kDebugMode) {
    print('Response body: ${response.body}');
  }

  final responseData = jsonDecode(response.body);
  // التعامل مع الاستجابة...
} catch (e) {
  if (kDebugMode) {
    print('Error: $e');
  } // Print error for debugging
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('حدث خطأ غير متوقع: $e')),
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
                'تسجيل حساب جديد',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              _buildTextField(_nameController, Icons.person_outline, 'الاسم الكامل'),
              const SizedBox(height: 16),
              _buildTextField(_emailController, Icons.email_outlined, 'الإيميل'),
              const SizedBox(height: 16),
              _buildTextField(_phoneController, Icons.phone_outlined, 'رقم الجوال'),
              const SizedBox(height: 16),
              _buildTextField(_passwordController, Icons.lock_outline, 'كلمة السر', obscureText: true),
              const SizedBox(height: 16),
              _buildTextField(_confirmPasswordController, Icons.lock_outline, 'تأكيد كلمة السر', obscureText: true),
              const SizedBox(height: 16),
              _buildTermsAndConditions(),
              const SizedBox(height: 16),
              _buildRegisterButton(),
              const SizedBox(height: 32),
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

  Row _buildTermsAndConditions() {
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value!;
            });
          },
        ),
        const Expanded(
          child: Text(
            'من خلال تحديد المربع، فإنك توافق على الشروط والأحكام الخاصة بنا.',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  ElevatedButton _buildRegisterButton() {
    return ElevatedButton(
      onPressed: _registerUser,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 82, 58, 149),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        'تسجيل',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
