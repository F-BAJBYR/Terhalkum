import 'package:flutter/material.dart';
import 'package:terhalkum/Authentication/Verification%20code.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('نسيت كلمة المرور'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'حدد مع تفاصيل الاتصال التي يجب أن نستخدمها لإعادة تعيين كلمة المرور الخاصة بك',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'البريد الإلكتروني',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'رقم الجوال',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // الانتقال إلى شاشة التحقق
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VerifyCodePage()),
                  );
                },
                child: const Text('إرسال'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
