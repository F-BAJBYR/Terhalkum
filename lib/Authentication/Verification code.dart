import 'package:flutter/material.dart';
import 'package:terhalkum/Authentication/Reset%20password%20-%20Email%20address.dart';

class VerifyCodePage extends StatelessWidget {
  const VerifyCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('رمز التحقق'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'يرجى إدخال رمز التحقق الذي أرسلناه إلى بريدك الإلكتروني',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // نموذج لأربع حقول لأرقام الرمز
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return const SizedBox(
                  width: 50,
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {},
              child: const Text('إعادة إرسال الرمز'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // الانتقال إلى شاشة إعادة تعيين كلمة المرور
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ResetPasswordPage()),
                  );
                },
                child: const Text('أستمر'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}